#!/bin/bash
# Script only allowing traffic originating from
# CloudFlare's subnets permitted to desired port.

# Notice: this script presumes you have already
# enabled IPv6 through '/etc/default/ufw'.

# Permission check.
if [ "$(id -u)" -ne 0 ]; then echo "Run with root privilege ." >&2; exit 1; fi

host_port=8443

# CloudFlare's subnets.
cloudflare_ipv6_subnets=(
    '2400:cb00::/32'
    '2606:4700::/32'
    '2803:f800::/32'
    '2405:b500::/32'
    '2405:8100::/32'
    '2a06:98c0::/29'
    '2c0f:f248::/32'
)

# Script magic.
for subnet_progress in ${cloudflare_ipv6_subnets[@]}; do
    ufw allow in from $subnet_progress to any port $host_port
done

# Completion notice.
echo "Script completed."