#!/bin/sh
#
# script for send gratious arp of all binded ips on all interfaces
# more info at https://tools.ietf.org/html/5227


IPRANGE_FILTER='^(172|127).'
IFNAME="$1"


if [ -z "$IFNAME" ]; then
    echo Please define interface name or 'all'
    exit 1
fi


get_ips () {
    if [ "$IFNAME" = 'all' ]; then
        ip -o a | awk -F ' +|/' '{if ($3 == "inet") print $2","$4}'
    else
        ip -o a | awk -F ' +|/' '$2 ~ /'$IFNAME'/ {if ($3 == "inet") print $2","$4}'
    fi
}

log () {
    severity=${severity:=info}
    logger --tag postup-arping --priority $severity "$1"
}

cmd () {
    arping -S $ip -c 4 -A -I $if $ip
}

main () {
    for i in $(get_ips); do
        ip=$(echo $i | cut -d ',' -f 2)
        iface=$(echo $i | cut -d ',' -f 1)
        if echo "$ip" | grep -q -E "$IPRANGE_FILTER"; then
            severity=error log "unsupported iprange $ip"
            continue
        fi
        log "send arp broadcast on $iface, ip $ip"
        $iface $ip $(cmd) > /dev/null 2>&1
    done
}


main &
