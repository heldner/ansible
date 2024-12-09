#!/bin/sh

set -e

IPSET_DIR=/etc/ipset/portsentry.tables

reload() {
    file="$1"
    awk '/^create / {sub(/_tmp/,""); print $0}' "$file" | \
    while read -r ip_set; do
        ipset -exist $ip_set
    done
    ipset -exist restore < "$file"
}

for rules in $IPSET_DIR; do
    reload "$rules"
done
