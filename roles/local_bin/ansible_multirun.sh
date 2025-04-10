#!/bin/sh

set -e

usage() {
    printf "    %s\n" "Run multiple playbooks "\
           ""\
           "USAGE: $0 <ROLE> <A_ENV> <LIMIT>"\
           "    A_ENV - stage or production"\
           "    (by default converge)"
    exit 0
}

[ "$#" -eq 0 ] && usage || ROLE="$1"

#if [ -n "$1" ]; then ROLE="$1"; else echo ROLE undefined; exit 1; fi
if [ -n "$2" ]; then A_ENV="$2"; else echo A_LENV undefined; exit 1; fi
if [ -n "$3" ]; then LIMIT="$3"; else echo LIMIT undefined; exit 1; fi

shift 3
OPTS="$@"

if [ -z "$LIMIT" ]; then echo LIMIT undefined; exit 1; fi

# for PB in "cleanup" "prepare" "converge"; do
for PB in "converge" ; do
    ansible-playbook \
        "roles/${ROLE}/molecule/default/${PB}.yml" \
        -i "inventories/${A_ENV}" \
        -l "$LIMIT" -D $OPTS
done
