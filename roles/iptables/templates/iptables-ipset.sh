#!/bin/sh

set -e
[ "$DEBUG" = "true" ] && set -x

IPSET_DIR="{{ iptables_ipset_config_dir }}"
IPTABLES_V4_RULES="{{ iptables_v4_rules }}"

if [ -z "$SUDO_USER" ] && [ -n "$USER" ]; then
    SUDO=sudo
fi

reload() {
    file="$1"
    awk '/^create / {sub(/_tmp/,""); print $0}' "$file" | \
    while read -r ip_set; do
        $SUDO ipset -exist $ip_set
    done
    $SUDO ipset -exist restore < "$file"
}

rule_deny() {
    $SUDO iptables-save | grep  " $1 " | sed 's,^-A,-D,'
}

log() {
    date +"%F:%m-%R $1"
}

clean_iptables() {
    rule=$(rule_deny $1)
    if [ -n "$rule" ]; then
        echo $rule | while read -r line; do
            eval $SUDO iptables $line
        done
    fi
}

clean_ipset() {
    name="$1"
    $SUDO rm -f "${IPSET_DIR}/${name}.tables" 2>/dev/null
    $SUDO ipset destroy "$name" 2>&1 || true
}

clean_all() {
    for ipset in $(echo "$1" | sed 's:,:\n:'); do
        clean_iptables "$ipset"
        sleep 0.1
        clean_ipset "$ipset"
    done
}


reload_all() {
    for rules in "$IPSET_DIR"/*; do
        reload "$rules"
    done
}

show_rules() {
    set -x
    $SUDO ipset list
    $SUDO iptables-save -t nat
    $SUDO iptables-save
}

save_rules() {
    $SUDO iptables-save | $SUDO /usr/bin/tee "$IPTABLES_V4_RULES" > /dev/null
}

accept_input_policy() {
    $SUDO iptables -P INPUT ACCEPT
}

drop_input_policy() {
    $SUDO iptables -P INPUT DROP
}

usage() {
    printf "    %s\n" "Usage: $0 <arg> <opt>" \
        "    --clean <ipset name>  - comma separated lists" \
        "    --disable             - policy accept input" \
        "    --enable              - policy drop input" \
        "    --reload              - reload ipsets" \
        "    -h|--help             - this help"
}

case $1 in
    --clean)
        shift
        clean_all "$1"
        save_rules
        ;;
    --reload)
        reload_all ;;
    --enable)
        drop_input_policy ;;
    --disable)
        accept_input_policy ;;
    -h|--help)
        usage ;;
    *)
        show_rules ;;
esac
