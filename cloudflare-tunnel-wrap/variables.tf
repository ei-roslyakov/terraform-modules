# ------------------------------------------------------------------------------
# Required
# ------------------------------------------------------------------------------
variable "account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "zone" {
  description = "Cloudflare DNS zone name (e.g. example.com)"
  type        = string
}

variable "tunnel_name" {
  description = "Name of the Cloudflare tunnel"
  type        = string
}

# ------------------------------------------------------------------------------
# Public services — exposed via tunnel ingress + public DNS
# ------------------------------------------------------------------------------
variable "public_services" {
  description = "Map of publicly accessible services routed through the tunnel"
  type = map(object({
    service       = string
    no_tls_verify = optional(bool, false)
  }))
  default = {}
}

# ------------------------------------------------------------------------------
# Private (WARP) hosts — accessible only with WARP client
# ------------------------------------------------------------------------------
variable "warp_hosts" {
  description = "Map of private hosts accessible via WARP (key = subdomain, value = IP CIDR + ports + description + per-host ACL)"
  type = map(object({
    ip             = string
    ports          = optional(list(number), [])
    service        = optional(string, "")
    no_tls_verify  = optional(bool, false)
    description    = optional(string, "")
    allowed_emails = optional(set(string), [])
  }))
  default = {}
}

# ------------------------------------------------------------------------------
# Access control
# ------------------------------------------------------------------------------
variable "allowed_emails" {
  description = "Email addresses allowed to enroll in WARP and access private services"
  type        = set(string)
  default     = []
}

variable "allowed_domains" {
  description = "Email domains allowed to enroll in WARP and access private services"
  type        = set(string)
  default     = []
}

# ------------------------------------------------------------------------------
# WARP enrollment application
# ------------------------------------------------------------------------------
variable "warp_session_duration" {
  description = "How long a WARP session lasts before re-authentication is required (e.g. 24h, 1h, 30m)"
  type        = string
  default     = "24h"
}

variable "warp_auto_redirect_to_identity" {
  description = "Skip the identity provider selection step during WARP enrollment login"
  type        = bool
  default     = false
}

variable "warp_allowed_idps" {
  description = "List of identity provider IDs that users can select during WARP enrollment. Empty = all configured IdPs"
  type        = list(string)
  default     = []
}

variable "warp_app_launcher_visible" {
  description = "Show the WARP enrollment app in the Cloudflare App Launcher"
  type        = bool
  default     = true
}

variable "warp_logo_url" {
  description = "Logo image URL for the WARP enrollment app in the App Launcher"
  type        = string
  default     = ""
}

variable "warp_custom_deny_message" {
  description = "Custom error message shown when WARP enrollment access is denied"
  type        = string
  default     = ""
}

variable "warp_custom_deny_url" {
  description = "Custom URL to redirect users to when WARP enrollment access is denied"
  type        = string
  default     = ""
}

variable "warp_landing_page_design" {
  description = "Customize the WARP enrollment login page appearance"
  type = object({
    title             = optional(string, "")
    message           = optional(string, "")
    image_url         = optional(string, "")
    button_color      = optional(string, "")
    button_text_color = optional(string, "")
  })
  default = null
}

# ------------------------------------------------------------------------------
# Device profile tuning
# ------------------------------------------------------------------------------
variable "device_profile_name" {
  description = "Name for the WARP device profile"
  type        = string
  default     = "Tunnel profile"
}

variable "device_profile_precedence" {
  description = "Precedence for the WARP device profile (lower = higher priority)"
  type        = number
  default     = 10
}

variable "tunnel_protocol" {
  description = "WARP tunnel protocol (wireguard or masque)"
  type        = string
  default     = "wireguard"
}

variable "device_allow_mode_switch" {
  description = "Allow users to switch between WARP modes"
  type        = bool
  default     = false
}

variable "device_allowed_to_leave" {
  description = "Allow users to disconnect WARP"
  type        = bool
  default     = true
}

variable "device_allow_updates" {
  description = "Allow WARP client to auto-update"
  type        = bool
  default     = true
}

variable "device_auto_connect" {
  description = "Auto-reconnect timeout in seconds (0 = disabled)"
  type        = number
  default     = 0
}

variable "device_captive_portal" {
  description = "Captive portal detection timeout in seconds"
  type        = number
  default     = 180
}

variable "device_disable_auto_fallback" {
  description = "Disable automatic fallback to direct connection when WARP is unreachable"
  type        = bool
  default     = false
}

variable "device_exclude_office_ips" {
  description = "Exclude Cloudflare office IPs from WARP routing"
  type        = bool
  default     = false
}

variable "device_support_url" {
  description = "Custom support URL shown in the WARP client"
  type        = string
  default     = ""
}
