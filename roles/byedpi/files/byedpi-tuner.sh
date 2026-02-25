#!/bin/bash
#
# byedpi-tuner.sh - скрипт подбора параметров byedpi
# Перебирает комбинации аргументов и тестирует доступ через curl
#

BYEDPI_BIN="${BYEDPI_BIN:-/usr/local/bin/byedpi}"
LISTEN_IP="${LISTEN_IP:-127.0.0.1}"
LISTEN_PORT="${LISTEN_PORT:-2081}"
TEST_URL="${TEST_URL:-https://facebook.com}"
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

# Наборы параметров на основе https://github.com/hufrea/byedpi/discussions/224
# Позиции: +s = SNI offset, +h = HTTP host, +e = end, +m = middle
declare -a PARAM_SETS=(
    # === Минималистичные базовые варианты ===
    "--disorder 1"
    "--disorder 1+s"
    "--split 1+s"
    "--tlsrec 1+s"

    # === Рабочие конфиги из обсуждения ===
    # Axa-Ru (Ростелеком)
    "--disorder 1 --auto torst --tlsrec 1+s"

    # sakontwist: proto tls
    "--disorder 2 --split 7 --round 1"
    "--disorder 0+se"
    "--disorder +s --split 0+sm --round 1"

    # === disorder + tlsrec (разрез SNI пополам) ===
    "--disorder 1 --tlsrec 1+s"
    "--disorder 2 --tlsrec 1+s"
    "--disorder 1+s --tlsrec 1+s"

    # === split + tlsrec ===
    "--split 1 --tlsrec 1+s"
    "--split 1+s --tlsrec 1+s"
    "--split 2 --tlsrec 1+s"

    # === С auto для переключения при блокировке ===
    "--disorder 1 --auto torst --disorder 2 --split 7"
    "--split 1+s --auto torst --disorder 1+s --tlsrec 1+s"
    "--disorder 1+s --auto torst,ssl_err --disorder 2 --tlsrec 1+s"

    # === fake с низким TTL (пакет не дойдёт до сервера) ===
    "--fake 1 --ttl 1"
    "--fake 1 --ttl 2"
    "--fake 1+s --ttl 2"
    "--fake 1 --ttl 3 --disorder 1"
    "--fake 1+s --ttl 2 --tlsrec 1+s"

    # === OOB data ===
    "--oob 1"
    "--oob 1+s"
    "--oob 1+s --tlsrec 1+s"

    # === disoob (disorder + oob) ===
    "--disoob 1"
    "--disoob 1+s"

    # === HTTP modification (для HTTP трафика) ===
    "--mod-http h,d"
    "--disorder 1 --mod-http h,d"
    "--split 1 --mod-http h,d"

    # === Комбинации с --round 1 ===
    "--disorder 1 --round 1"
    "--split 1+s --round 1"
    "--disorder 1+s --tlsrec 1+s --round 1"

    # === Продвинутые комбинации ===
    "--disorder 1 --split 3 --tlsrec 1+s"
    "--split 1 --disorder 3 --tlsrec 1+s"
    "--disorder 1+s --split 3+s --round 1"

    # === С несколькими split позициями ===
    "--split 1+s --split 3+s"
    "--disorder 1 --split 1+s --split 5+s"

    # === auto с timeout для проблемных соединений ===
    "--timeout 3 --auto torst --disorder 1+s --tlsrec 1+s"
    "--timeout 3 --auto torst,ssl_err --disorder 2 --split 7 --round 1"

    # === md5sig для fake (может помочь ночью) ===
    "--fake 1 --ttl 2 --md5sig"
    "--fake 1+s --ttl 2 --md5sig --disorder 1"

    # === Полные рабочие стратегии ===
    # TLS: disorder + tlsrec
    "--disorder 1 --tlsrec 1+s --auto torst --disorder 2 --tlsrec 1+s"
    # TLS: split + disorder fallback
    "--split 1+s --tlsrec 1+s --auto torst --disorder 1+s --tlsrec 1+s"
    # Universal с HTTP fallback
    "--disorder 1 --tlsrec 1+s --auto torst --mod-http h,d --disorder 2"
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
