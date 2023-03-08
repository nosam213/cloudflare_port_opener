#!/bin/bash
# Script only allowing traffic originating from
# CloudFlare's subnets permitted to desired port.

# Notice: this script presumes you have already
# enabled IPv6 through '/etc/default/ufw'.

# Permission check.
if [ "$(id -u)" -ne 0 ]; then echo "Run with root privilege ." >&2; exit 1; fi

host_port=8443

# CloudFlare's subnets.
cloudflare_ipv4_subnets=(
    '173.245.48.0/20'
    '103.21.244.0/22'
    '103.22.200.0/22'
    '103.31.4.0/22'
    '141.101.64.0/18'
    '108.162.192.0/18'
    '190.93.240.0/20'
    '188.114.96.0/20'
    '197.234.240.0/22'
    '198.41.128.0/17'
    '162.158.0.0/15'
    '104.16.0.0/13'
    '104.24.0.0/14'
    '172.64.0.0/13'
    '131.0.72.0/22'
)
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
for subnet_progress_ipv4 in ${cloudflare_ipv4_subnets[@]}; do
    ufw allow in from $subnet_progress_ipv4 to any port $host_port
done
for subnet_progress_ipv6 in ${cloudflare_ipv6_subnets[@]}; do
    ufw allow in from $subnet_progress_ipv6 to any port $host_port
done

# Completion notice.
echo "Script completed."