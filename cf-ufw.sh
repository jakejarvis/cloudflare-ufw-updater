#!/bin/sh
#
#  UFW rule updater to only allow HTTP and HTTPS traffic from Cloudflare IP addresses.
#  Readme: https://github.com/jakejarvis/cloudflare-ufw-updater/blob/master/README.md
#
#  Inspired by https://github.com/Paul-Reed/cloudflare-ufw/blob/master/cloudflare-ufw.sh
#
#  To run as a daily cron job:
#    1. sudo crontab -e
#    2. Add this line to the end:
#        @daily /this/file/location/cf-ufw.sh &> /dev/null
#

# Fetch latest IP range lists (both v4 and v6) from Cloudflare
curl -s https://www.cloudflare.com/ips-v4 -o /tmp/cf_ips
curl -s https://www.cloudflare.com/ips-v6 >> /tmp/cf_ips

# Restrict traffic to ports 80 (TCP) & 443 (TCP)
# UFW will skip a subnet if a rule already exists (which it probably does)
for ip in $(cat /tmp/cf_ips); do ufw allow from "$ip" to any port 80,443 proto tcp comment 'Cloudflare'; done

# Delete downloaded lists from above
rm /tmp/cf_ips

# Need to reload UFW before new rules take effect
ufw reload
