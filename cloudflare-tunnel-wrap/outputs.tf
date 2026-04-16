output "tunnel_id" {
  description = "ID of the Cloudflare tunnel"
  value       = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

output "tunnel_token" {
  description = "Token used to run cloudflared on the connector host"
  value       = data.cloudflare_zero_trust_tunnel_cloudflared_token.this.token
  sensitive   = true
}

output "tunnel_cname" {
  description = "CNAME target for the tunnel (e.g. <id>.cfargotunnel.com)"
  value       = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
}

output "zone_id" {
  description = "Cloudflare zone ID (looked up from zone name)"
  value       = data.cloudflare_zone.this.id
}

output "warp_enrollment_app_id" {
  description = "ID of the WARP enrollment Access Application"
  value       = length(cloudflare_zero_trust_access_application.warp) > 0 ? cloudflare_zero_trust_access_application.warp[0].id : null
}

output "device_profile_id" {
  description = "ID of the WARP device custom profile"
  value       = length(cloudflare_zero_trust_device_custom_profile.this) > 0 ? cloudflare_zero_trust_device_custom_profile.this[0].id : null
}

output "public_dns_records" {
  description = "Map of public service subdomain to DNS record ID"
  value       = { for k, v in cloudflare_dns_record.public : k => v.id }
}

output "warp_dns_records" {
  description = "Map of WARP host subdomain to DNS record ID"
  value       = { for k, v in cloudflare_dns_record.warp : k => v.id }
}
