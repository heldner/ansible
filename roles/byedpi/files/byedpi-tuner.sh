#!/bin/bash
#
# byedpi-tuner.sh - скрипт подбора параметров byedpi
# Перебирает комбинации аргументов и тестирует доступ через curl
#

BYEDPI_BIN="${BYEDPI_BIN:-/usr/local/bin/byedpi}"
LISTEN_IP="${LISTEN_IP:-127.0.0.1}"
LISTEN_PORT="${LISTEN_PORT:-2081}"
#TEST_URL="${TEST_URL:-https://facebook.com}"
TEST_URL="${TEST_URL:-https://instagram.com}"
CURL_TIMEOUT="${CURL_TIMEOUT:-10}"
STARTUP_DELAY="${STARTUP_DELAY:-1}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

BYEDPI_PID=""

cleanup() {
    if [[ -n "$BYEDPI_PID" ]]; then
        kill "$BYEDPI_PID" 2>/dev/null || true
        wait "$BYEDPI_PID" 2>/dev/null || true
        BYEDPI_PID=""
    fi
}

trap cleanup EXIT INT TERM

start_byedpi() {
    local args="$1"
    cleanup

    $BYEDPI_BIN --ip "$LISTEN_IP" --port "$LISTEN_PORT" $args >/dev/null 2>&1 &
    BYEDPI_PID=$!

    sleep "$STARTUP_DELAY"

    if ! kill -0 "$BYEDPI_PID" 2>/dev/null; then
        BYEDPI_PID=""
        return 1
    fi
    return 0
}

test_connection() {
    local http_code
    http_code=$(curl -L -s -o /dev/null -w "%{http_code}" \
        --socks5 "${LISTEN_IP}:${LISTEN_PORT}" \
        --connect-timeout "$CURL_TIMEOUT" \
        --max-time "$CURL_TIMEOUT" \
        "$TEST_URL" 2>/dev/null) || http_code="000"

    echo "$http_code"
    if [[ "$http_code" =~ ^(200|301|302|303|307|308)$ ]]; then
        return 0
    fi
    return 1
}

# Наборы параметров на основе https://github.com/hufrea/byedpi/discussions/184
# и https://github.com/hufrea/byedpi/discussions/58
# Позиции: +s = SNI offset, +h = HTTP host, +e = end, +m = middle
# Краткие флаги: -s=--split, -q=--disoob, -o=--oob, -d=--disorder,
#                -f=--fake, -r=--tlsrec, -A=--auto, -Y=--drop-sack
declare -a PARAM_SETS=(
    # === Самый популярный конфиг (#184, waptaxi) ===
    # Работает: Ростелеком, Билайн, МГТС, мобильные операторы
    "-s1 -q1 -Y -Ar -s5 -o1+s -At -f-1 -r1+s -As -s1 -o1+s -s-1 -An"

    # === Вариации основного конфига (#184, sgt-cartman, Билайн) ===
    "-s1 -o1 -Ar -o1 -At -f-1 -r1+s -As"
    "-s1 -o1 -Ar -o3 -At -f-1 -r1+s -As"

    # === Без -Y (для совместимости, -Y=--drop-sack только Linux) ===
    "-s1 -q1 -Ar -s5 -o1+s -At -f-1 -r1+s -As -s1 -o1+s -s-1 -An"

    # === Mihrutkin, сентябрь 2025 (#184) ===
    "-Ku -a1 -An -o1 -At,r,s -d1 -a2 -o1 -o25+s -T3 -At --tlsrec 1+s -a2"
    "-s1 -q1 -Y -a2 -Ar,t -f-1 -r1+s -a3"

    # === disorder + auto (#184, denizzzka) ===
    "--disorder 4 --auto torst,sid_inv,alert --timeout 2.5 --disorder 7"

    # === oob + md5sig (#184, koshcheev713) ===
    "--oob 1 --split 2 --mod-http h,d --auto torst --fake -1 --tlsrec 3+s --md5sig --auto none"

    # === Билайн провод + DroidProger, без --hosts (#184) ===
    "--oob 1 --tlsrec 5+s --auto none"
    "--oob 2 --tlsrec 3+s --auto none"
    "--split 5 --disoob 15 --drop-sack --auto none"

    # === DenisIndenbom, МГТС, оригинал (#58) ===
    "--split 1 --disorder 3+s --mod-http h,d --auto none --tlsrec 1+s"
    "--split 1 --disorder 3+s --mod-http h,d --auto none --fake -1 --tlsrec 3+h"

    # === DenisIndenbom, обновлённый октябрь 2024 (#58) ===
    "--split 1 --disoob 3 --disorder 7 --fake -1 --auto none --tlsrec 3+h --mod-http h,d,r"
    "--split 1 --disoob 3 --disorder 7 --fake -1 --auto-mode 1 --auto none --tlsrec 3+h --mod-http h,d,r"
    "--split 1 --oob 1 --auto redirect --oob 1 --auto torst --fake -1 --tlsrec 1+s --auto ssl_error"

    # === Ростелеком Новосибирск (#58, decide-you) ===
    "--split 1 --oob 1 --mod-http h,d --auto none --fake -1 --tlsrec 3+h"

    # === Ростелеком (#58, rezawq) ===
    "--split 2 --disorder 3 --fake -1 --ttl 5"
    "--split 2 --disorder 3 --ttl 5 --tlsrec 3+s --auto torst --timeout 3"

    # === sakontwist, proto tls (#224) ===
    "--proto tls --disorder 2 --split 7 --round 1"
    "--proto tls --disorder +s --split 0+sm --round 1"

    # === Минималистичные базовые варианты ===
    "--oob 1"
    "--oob 1+s"
    "--disoob 1"
    "--disoob 1+s"
    "--tlsrec 1+s"
    "--disorder 1 --tlsrec 1+s"
    "--split 1+s --tlsrec 1+s"
)

main() {
    echo -e "${YELLOW}byedpi parameter tuner${NC}"
    echo "Binary: $BYEDPI_BIN"
    echo "Listen: ${LISTEN_IP}:${LISTEN_PORT}"
    echo "Test URL: $TEST_URL"
    echo "---"

    if [[ ! -x "$BYEDPI_BIN" ]]; then
        echo -e "${RED}ERROR: $BYEDPI_BIN not found or not executable${NC}"
        exit 1
    fi

    echo "Testing ${#PARAM_SETS[@]} parameter combinations..."
    echo ""

    local count=0
    local total=${#PARAM_SETS[@]}
    local http_code
    local success_count=0
    local fail_count=0
    local error_count=0
    declare -a working_params=()
    declare -a failed_params=()

    for params in "${PARAM_SETS[@]}"; do
        count=$((count + 1))
        echo -n "[${count}/${total}] ${params} ... "

        if ! start_byedpi "$params"; then
            echo -e "${RED}FAILED TO START${NC}"
            error_count=$((error_count + 1))
            continue
        fi

        http_code=$(test_connection)

        if [[ "$http_code" =~ ^(200|301|302|303|307|308)$ ]]; then
            echo -e "${GREEN}OK (HTTP ${http_code})${NC}"
            success_count=$((success_count + 1))
            working_params+=("$params|$http_code")
        else
            echo -e "${RED}FAIL (HTTP ${http_code})${NC}"
            fail_count=$((fail_count + 1))
            failed_params+=("$params|$http_code")
        fi
    done

    cleanup

    echo ""
    echo "==========================================="
    echo -e "${YELLOW}RESULTS${NC}"
    echo "==========================================="
    echo ""
    echo "Total tests: $total"
    echo -e "Success: ${GREEN}${success_count}${NC}"
    echo -e "Failed:  ${RED}${fail_count}${NC}"
    if [[ $error_count -gt 0 ]]; then
        echo -e "Errors:  ${RED}${error_count}${NC}"
    fi
    echo ""

    if [[ ${#working_params[@]} -gt 0 ]]; then
        echo -e "${GREEN}=== WORKING PARAMETERS (${#working_params[@]}) ===${NC}"
        echo ""
        for item in "${working_params[@]}"; do
            params="${item%|*}"
            code="${item##*|}"
            echo -e "${GREEN}[HTTP ${code}]${NC} ${params}"
        done
        echo ""
        echo "--- Best options for systemd service ---"
        echo ""
        local best="${working_params[0]}"
        best="${best%|*}"
        echo "$BYEDPI_BIN --ip $LISTEN_IP --port $LISTEN_PORT $best"
        echo ""
    else
        echo -e "${RED}No working parameters found${NC}"
        exit 1
    fi
}

main "$@"
