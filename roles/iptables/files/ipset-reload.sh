#!/bin/sh

IPSET_RULES=/etc/ipset.tables
TMP_IPSET_RULES=/tmp/ipset.tables.tmp

reload() {
    set -e
    awk '/^create / {sub(/_tmp/,""); print $0}' $IPSET_RULES | \
    while read ip_set; do
        ipset -exist $ip_set
    done
    ipset -exist restore < $IPSET_RULES

}

main() {
    if reload; then
        cp $IPSET_RULES $TMP_IPSET_RULES
    fi
}


if [ "$1" = '--force-reload' ];then
  rm $TMP_IPSET_RULES
fi

if [ ! -f $TMP_IPSET_RULES  ]; then
    main
else
    diff $IPSET_RULES $TMP_IPSET_RULES > /dev/null
    if [ $? -eq 1 ]; then
        main
    fi
fi
