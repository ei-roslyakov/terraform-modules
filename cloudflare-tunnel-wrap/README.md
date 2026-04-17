# cloudflare_tunnel

Terraform module that creates a fully configured Cloudflare Tunnel with public service exposure, WARP private network access, per-host ACLs, Gateway network policies, and device profiles.

## What it creates

| Resource | Description |
|---|---|
| `cloudflare_zero_trust_tunnel_cloudflared` | The tunnel itself |
| `cloudflare_zero_trust_tunnel_cloudflared_config` | Ingress rules + WARP routing |
| `cloudflare_dns_record` | CNAME records for public services and WARP hosts |
| `cloudflare_zero_trust_tunnel_cloudflared_route` | Private network routes through the tunnel |
| `cloudflare_zero_trust_gateway_policy` | Per-host allow + catch-all block network policies |
| `cloudflare_zero_trust_device_custom_profile` | Split-tunnel include device profile |
| `cloudflare_zero_trust_access_policy` | Global + per-host access policies |
| `cloudflare_zero_trust_access_application` | WARP enrollment app + per-host self-hosted apps |

## Architecture

```
                    Internet
                       |
            +----------+----------+
            |                     |
      Public services        WARP client
      (anyone can access)    (enrolled users only)
            |                     |
      DNS CNAME -->          Split-tunnel include
      Tunnel ingress -->     Tunnel route -->
      Origin server          Private IP/network
                                  |
                           Gateway policies
                           (per-host email + port ACLs)
```

**Two access paths for private hosts:**
1. **Hostname** (`pve.example.com`) -- requires Cloudflare Access login, no WARP needed
2. **IP** (`192.168.1.200:8006`) -- requires WARP client enrolled, controlled by Gateway policies

## Usage

### Minimal -- public services only

```hcl
module "tunnel" {
  source = "../../modules/cloudflare_tunnel"

  account_id  = "your-account-id"
  zone        = "example.com"
  tunnel_name = "my-tunnel"

  public_services = {
    "app"     = { service = "http://10.0.0.10:8080" }
    "grafana" = { service = "http://10.0.0.10:3000" }
  }
}
```

### Public + private with WARP

```hcl
module "homelab" {
  source = "../../modules/cloudflare_tunnel"

  account_id  = "your-account-id"
  zone        = "example.com"
  tunnel_name = "homelab-tunnel"

  public_services = {
    "app"     = { service = "http://192.168.1.10:8080" }
    "grafana" = { service = "http://192.168.1.10:3000" }
    "pve"     = { service = "https://192.168.1.200:8006", no_tls_verify = true }
  }

  warp_hosts = {
    "proxmox" = {
      ip             = "192.168.1.200/32"
      ports          = [8006]
      no_tls_verify  = true
      description    = "Proxmox VE"
      allowed_emails = ["admin@example.com"]
    }
  }

  allowed_emails      = ["admin@example.com"]
  device_profile_name = "Homelab"
}
```

### Full network with per-host ACLs

```hcl
module "office" {
  source = "../../modules/cloudflare_tunnel"

  account_id  = "your-account-id"
  zone        = "example.com"
  tunnel_name = "office-tunnel"

  public_services = {
    "wiki" = { service = "http://10.0.0.50:8080" }
  }

  warp_hosts = {
    # Whole network -- admin only
    "office-net" = {
      ip             = "10.0.0.0/24"
      ports          = [22, 80, 443, 8080]
      description    = "Office network"
      allowed_emails = ["admin@example.com"]
    }
    # Single host -- shared with contractor
    "nas" = {
      ip             = "10.0.0.100/32"
      ports          = [443]
      description    = "NAS"
      allowed_emails = ["admin@example.com", "contractor@example.com"]
    }
    # No port restriction
    "dev-server" = {
      ip             = "10.0.0.200/32"
      description    = "Dev server -- all ports"
      allowed_emails = ["admin@example.com", "dev@example.com"]
    }
  }

  allowed_emails  = ["admin@example.com", "contractor@example.com", "dev@example.com"]
  allowed_domains = ["example.com"]

  device_profile_name = "Office"
  tunnel_protocol     = "wireguard"
}
```

### Fully customized WARP enrollment

```hcl
module "branded" {
  source = "../../modules/cloudflare_tunnel"

  account_id  = "your-account-id"
  zone        = "example.com"
  tunnel_name = "branded-tunnel"

  warp_hosts = {
    "internal" = {
      ip             = "10.0.0.0/16"
      description    = "Internal network"
      allowed_emails = ["user@example.com"]
    }
  }

  allowed_emails = ["user@example.com"]

  # --- WARP enrollment app ---
  warp_session_duration          = "1h"
  warp_auto_redirect_to_identity = true
  warp_app_launcher_visible      = true
  warp_logo_url                  = "https://example.com/logo.png"
  warp_custom_deny_message       = "Access denied. Contact IT at support@example.com"
  warp_custom_deny_url           = "https://example.com/access-denied"
  warp_landing_page_design = {
    title             = "Welcome to Example Corp VPN"
    message           = "Sign in with your corporate email to connect."
    button_color      = "#0055ff"
    button_text_color = "#ffffff"
  }

  # --- Device profile ---
  device_profile_name       = "Corp VPN"
  device_profile_precedence = 5
  device_allow_mode_switch  = false
  device_allowed_to_leave   = false
  device_allow_updates      = true
  device_auto_connect       = 300
  device_captive_portal     = 180
  device_support_url        = "https://support.example.com"
}
```

## How access control works

### Two layers

| Layer | Controls | Mechanism |
|---|---|---|
| **Module-level** `allowed_emails` / `allowed_domains` | Who can enroll in WARP | Access Policy + WARP enrollment app |
| **Per-host** `allowed_emails` | Who can reach each IP/network + ports | Gateway network policy (allow/block) + Access Application |

### Flow

1. User installs WARP client and enters team name
2. Module-level `allowed_emails` controls enrollment (must be listed here)
3. Once enrolled, split-tunnel routes private IPs through WARP
4. Gateway network policies check per-host `allowed_emails` + `ports`
5. If not explicitly allowed, the catch-all block rule denies access

### Port restrictions

```hcl
ports = [22, 80, 443]   # Only these ports allowed via WARP
ports = [8006]           # Single port
ports = []               # All ports allowed (default)
```

Gateway policy expressions generated:
- Single port: `net.dst.ip == 10.0.0.1 and net.dst.port == 8006`
- Multiple ports: `net.dst.ip == 10.0.0.1 and net.dst.port in {22 80 443}`
- CIDR range: `net.dst.ip in {10.0.0.0/24} and net.dst.port in {22 80 443}`

## Inputs

### Required

| Name | Type | Description |
|---|---|---|
| `account_id` | `string` | Cloudflare account ID |
| `zone` | `string` | DNS zone name (e.g. `example.com`). Zone ID is looked up automatically |
| `tunnel_name` | `string` | Name of the tunnel |

### Services

| Name | Type | Default | Description |
|---|---|---|---|
| `public_services` | `map(object)` | `{}` | Public services exposed via tunnel. Keys = subdomains |
| `warp_hosts` | `map(object)` | `{}` | Private hosts/networks accessible via WARP |

#### `public_services` object

| Field | Type | Default | Description |
|---|---|---|---|
| `service` | `string` | required | Origin URL (e.g. `http://10.0.0.1:8080`) |
| `no_tls_verify` | `bool` | `false` | Skip TLS verification for HTTPS origins |

#### `warp_hosts` object

| Field | Type | Default | Description |
|---|---|---|---|
| `ip` | `string` | required | IP or CIDR (e.g. `10.0.0.1/32` or `10.0.0.0/24`) |
| `ports` | `list(number)` | `[]` | Allowed ports. Empty = all ports |
| `no_tls_verify` | `bool` | `false` | Skip TLS verification for hostname-based access |
| `description` | `string` | `""` | Description for dashboard and comments |
| `allowed_emails` | `set(string)` | `[]` | Per-host email ACL. Empty = use global policy |

### Access control

| Name | Type | Default | Description |
|---|---|---|---|
| `allowed_emails` | `set(string)` | `[]` | Emails allowed to enroll in WARP |
| `allowed_domains` | `set(string)` | `[]` | Email domains allowed to enroll in WARP |

### WARP enrollment application

| Name | Type | Default | Description |
|---|---|---|---|
| `warp_session_duration` | `string` | `"24h"` | Re-auth interval |
| `warp_auto_redirect_to_identity` | `bool` | `false` | Skip IdP selection page |
| `warp_allowed_idps` | `list(string)` | `[]` | Restrict to specific IdP IDs |
| `warp_app_launcher_visible` | `bool` | `true` | Show in App Launcher |
| `warp_logo_url` | `string` | `""` | Custom logo URL |
| `warp_custom_deny_message` | `string` | `""` | Custom denial message |
| `warp_custom_deny_url` | `string` | `""` | Redirect URL on denial |
| `warp_landing_page_design` | `object` | `null` | Login page branding (title, message, colors, image) |

### Device profile

| Name | Type | Default | Description |
|---|---|---|---|
| `device_profile_name` | `string` | `"Tunnel profile"` | Profile name in dashboard |
| `device_profile_precedence` | `number` | `10` | Priority (lower = higher) |
| `tunnel_protocol` | `string` | `"wireguard"` | `wireguard` or `masque` |
| `device_allow_mode_switch` | `bool` | `false` | Let users switch WARP modes |
| `device_allowed_to_leave` | `bool` | `true` | Let users disconnect |
| `device_allow_updates` | `bool` | `true` | Auto-update client |
| `device_auto_connect` | `number` | `0` | Auto-reconnect timeout (seconds, 0 = off) |
| `device_captive_portal` | `number` | `180` | Captive portal timeout (seconds) |
| `device_disable_auto_fallback` | `bool` | `false` | Disable fallback to direct |
| `device_exclude_office_ips` | `bool` | `false` | Exclude CF office IPs |
| `device_support_url` | `string` | `""` | Custom support link in client |

## Outputs

| Name | Description |
|---|---|
| `tunnel_id` | Tunnel UUID |
| `tunnel_token` | Token for running cloudflared (sensitive) |
| `tunnel_cname` | CNAME target (`<id>.cfargotunnel.com`) |
| `zone_id` | Looked-up zone ID |
| `warp_enrollment_app_id` | WARP enrollment Access Application ID |
| `device_profile_id` | Device custom profile ID |
| `public_dns_records` | Map of subdomain to DNS record ID |
| `warp_dns_records` | Map of WARP host subdomain to DNS record ID |

## Requirements

| Name | Version |
|---|---|
| Terraform | >= 1.3.0 |
| cloudflare/cloudflare | >= 5.0 |

## Connector setup

After `terraform apply`, run cloudflared on your server using the tunnel token:

```bash
# Get the token
terraform output -raw tunnel_token

# Run cloudflared (Docker example)
docker run -d --name cloudflared \
  cloudflare/cloudflared:latest \
  tunnel --no-autoupdate run \
  --token $(terraform output -raw tunnel_token)
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
