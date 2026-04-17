# ==============================================================================
# Cloudflare Tunnel — full-stack module
#
# Creates:
#   • Tunnel + connector token
#   • Public DNS records + ingress rules for external services
#   • WARP private-network routes for private hosts
#   • DNS + ingress + Access Applications for private host hostname access
#   • Gateway network policies for per-host IP-level ACLs
#   • Device profile (split-tunnel include) for WARP clients
#   • Access policy + WARP enrollment application
# ==============================================================================

locals {
  # Hosts that have per-host allowed_emails defined
  warp_hosts_with_acl = {
    for k, v in var.warp_hosts : k => v if length(v.allowed_emails) > 0
  }
  # Collect all unique private CIDRs for the catch-all block rule
  all_warp_cidrs = [for k, v in var.warp_hosts : v.ip]

  # Build IP match expression for Gateway policies
  _ip_expr = {
    for k, v in var.warp_hosts : k => (
      endswith(v.ip, "/32")
      ? "net.dst.ip == ${cidrhost(v.ip, 0)}"
      : "net.dst.ip in {${v.ip}}"
    )
  }

  # Build port match expression (empty list = all ports allowed)
  _port_expr = {
    for k, v in var.warp_hosts : k => (
      length(v.ports) == 0 ? "" :
      length(v.ports) == 1 ? " and net.dst.port == ${v.ports[0]}" :
      " and net.dst.port in {${join(" ", [for p in v.ports : tostring(p)])}}"
    )
  }
}

# ------------------------------------------------------------------------------
# Zone lookup
# ------------------------------------------------------------------------------
data "cloudflare_zone" "this" {
  filter = {
    name = var.zone
  }
}

# ------------------------------------------------------------------------------
# Tunnel
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id = var.account_id
  name       = var.tunnel_name
  config_src = "cloudflare"
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "this" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

# ------------------------------------------------------------------------------
# Public services — DNS records
# ------------------------------------------------------------------------------
resource "cloudflare_dns_record" "public" {
  for_each = var.public_services

  zone_id = data.cloudflare_zone.this.id
  name    = each.key
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# ------------------------------------------------------------------------------
# Private (WARP) hosts — DNS records for hostname-based access
# ------------------------------------------------------------------------------
resource "cloudflare_dns_record" "warp" {
  for_each = { for k, v in var.warp_hosts : k => v if !contains(keys(var.public_services), k) }

  zone_id = data.cloudflare_zone.this.id
  name    = each.key
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# ------------------------------------------------------------------------------
# Private (WARP) hosts — per-host Access Policies (when allowed_emails is set)
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_access_policy" "warp_host" {
  for_each = local.warp_hosts_with_acl

  account_id = var.account_id
  name       = "${each.key} — allowed users"
  decision   = "allow"

  include = [
    for email in each.value.allowed_emails : { email = { email = email } }
  ]
}

# ------------------------------------------------------------------------------
# Private (WARP) hosts — Access Applications (protect with login)
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_access_application" "warp_host" {
  for_each = { for k, v in var.warp_hosts : k => v if !contains(keys(var.public_services), k) }

  account_id = var.account_id
  type       = "self_hosted"
  name       = "${each.key} (private)"
  domain     = "${each.key}.${var.zone}"

  session_duration = "24h"

  # Use per-host policy if allowed_emails is set, otherwise fall back to global policy
  policies = [
    {
      id = (
        contains(keys(local.warp_hosts_with_acl), each.key)
        ? cloudflare_zero_trust_access_policy.warp_host[each.key].id
        : cloudflare_zero_trust_access_policy.this[0].id
      )
      precedence = 1
    }
  ]
}

# ------------------------------------------------------------------------------
# Tunnel config — ingress rules + WARP routing
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_tunnel_cloudflared_config" "this" {
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
  account_id = var.account_id

  config = {
    warp_routing = {
      enabled = length(var.warp_hosts) > 0
    }
    ingress = concat(
      [
        for subdomain, cfg in var.public_services : {
          hostname = "${subdomain}.${var.zone}"
          service  = cfg.service
          origin_request = cfg.no_tls_verify ? {
            no_tls_verify = true
          } : null
        }
      ],
      [
        for subdomain, host in var.warp_hosts : {
          hostname = "${subdomain}.${var.zone}"
          service  = host.service != "" ? host.service : "tcp://${cidrhost(host.ip, 0)}:${length(host.ports) > 0 ? host.ports[0] : 443}"
          origin_request = host.no_tls_verify ? {
            no_tls_verify = true
          } : null
        } if !contains(keys(var.public_services), subdomain)
      ],
      [{ service = "http_status:404" }]
    )
  }
}

# ==============================================================================
# WARP private access — everything below is created only when warp_hosts is set
# ==============================================================================

# ------------------------------------------------------------------------------
# Gateway network policies — per-host IP-level ACLs (WARP path)
# Allow only listed emails to reach each private IP
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_gateway_policy" "warp_allow" {
  for_each = local.warp_hosts_with_acl

  account_id  = var.account_id
  name        = "Allow ${each.key} (${each.value.ip})"
  description = each.value.description
  precedence  = index(keys(local.warp_hosts_with_acl), each.key) + 10
  enabled     = true
  action      = "allow"
  filters     = ["l4"]
  traffic     = "${local._ip_expr[each.key]}${local._port_expr[each.key]}"
  identity = join(" or ", [
    for email in each.value.allowed_emails : "identity.email == \"${email}\""
  ])
}

# Block all other users from reaching any private WARP IP
resource "cloudflare_zero_trust_gateway_policy" "warp_block_all" {
  count = length(local.warp_hosts_with_acl) > 0 ? 1 : 0

  account_id  = var.account_id
  name        = "Block unauthorized private access"
  description = "Deny access to private IPs for users not explicitly allowed"
  precedence  = 1000
  enabled     = true
  action      = "block"
  filters     = ["l4"]
  traffic     = join(" or ", [for k, v in var.warp_hosts : local._ip_expr[k]])
}

# ------------------------------------------------------------------------------
# Tunnel routes — advertise private CIDRs through cloudflared
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_tunnel_cloudflared_route" "warp" {
  for_each = var.warp_hosts

  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
  network    = each.value.ip
  comment    = each.value.description
}

# ------------------------------------------------------------------------------
# Device profile — split-tunnel include (only listed CIDRs via WARP)
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_device_custom_profile" "this" {
  count = length(var.warp_hosts) > 0 ? 1 : 0

  account_id  = var.account_id
  name        = var.device_profile_name
  description = "Route only private IPs through WARP"
  precedence  = var.device_profile_precedence
  enabled     = true

  match = join(" or ", [
    for email in var.allowed_emails : "identity.email == \"${email}\""
  ])

  tunnel_protocol = var.tunnel_protocol

  service_mode_v2 = {
    mode = "warp"
  }

  include = [
    for key, host in var.warp_hosts : {
      address     = host.ip
      description = host.description
    }
  ]

  allow_mode_switch     = var.device_allow_mode_switch
  allowed_to_leave      = var.device_allowed_to_leave
  allow_updates         = var.device_allow_updates
  auto_connect          = var.device_auto_connect
  captive_portal        = var.device_captive_portal
  disable_auto_fallback = var.device_disable_auto_fallback
  exclude_office_ips    = var.device_exclude_office_ips
  support_url           = var.device_support_url != "" ? var.device_support_url : null
}

# ------------------------------------------------------------------------------
# Access policy — who can enroll
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_access_policy" "this" {
  count = length(var.warp_hosts) > 0 ? 1 : 0

  account_id = var.account_id
  name       = "${var.tunnel_name} — allowed users"
  decision   = "allow"

  include = concat(
    [for email in var.allowed_emails : { email = { email = email } }],
    [for domain in var.allowed_domains : { email_domain = { domain = domain } }],
  )
}

# ------------------------------------------------------------------------------
# WARP enrollment application
# ------------------------------------------------------------------------------
resource "cloudflare_zero_trust_access_application" "warp" {
  count = length(var.warp_hosts) > 0 ? 1 : 0

  account_id                = var.account_id
  type                      = "warp"
  name                      = "${var.tunnel_name} WARP enrollment"
  session_duration          = var.warp_session_duration
  auto_redirect_to_identity = var.warp_auto_redirect_to_identity
  allowed_idps              = length(var.warp_allowed_idps) > 0 ? var.warp_allowed_idps : null
  logo_url                  = var.warp_logo_url != "" ? var.warp_logo_url : null
  custom_deny_message       = var.warp_custom_deny_message != "" ? var.warp_custom_deny_message : null
  custom_deny_url           = var.warp_custom_deny_url != "" ? var.warp_custom_deny_url : null

  landing_page_design = var.warp_landing_page_design != null ? {
    title             = var.warp_landing_page_design.title
    message           = var.warp_landing_page_design.message
    image_url         = var.warp_landing_page_design.image_url
    button_color      = var.warp_landing_page_design.button_color
    button_text_color = var.warp_landing_page_design.button_text_color
  } : null

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.this[0].id
      precedence = 1
    }
  ]
}
