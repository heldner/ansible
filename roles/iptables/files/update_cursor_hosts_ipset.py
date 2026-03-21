#!/usr/bin/env python3
"""
Скрипт для обновления ipset списка 'cursor-hosts' IP адресами из cursor.com
Формат записи: $ip,tcp:443
"""

import json
import subprocess
import sys
import urllib.request
from typing import List, Set


IPSET_NAME = "cursor-hosts"
IPSET_TYPE = "hash:ip,port"
JSON_URL = "https://cursor.com/docs/ips.json"


def load_ips_from_url(url: str) -> Set[str]:
    """Загружает IP адреса из JSON файла по URL"""
    try:
        with urllib.request.urlopen(url) as response:
            data = json.loads(response.read().decode('utf-8'))
    except urllib.request.URLError as e:
        print(f"Ошибка при загрузке данных: {e}", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Ошибка при парсинге JSON: {e}", file=sys.stderr)
        sys.exit(1)

    ips = set()

    # Извлекаем IP из всех регионов в backgroundAgents
    if 'backgroundAgents' in data:
        for region, ip_list in data['backgroundAgents'].items():
            for ip_entry in ip_list:
                # Убираем /32 из CIDR нотации, если есть
                ip = ip_entry.split('/')[0]
                ips.add(ip)

    return ips


def ipset_exists(name: str) -> bool:
    """Проверяет существование ipset списка"""
    try:
        result = subprocess.run(
            ['ipset', 'list', name],
            capture_output=True,
            text=True,
            check=False
        )
        return result.returncode == 0
    except FileNotFoundError:
        print("Ошибка: команда 'ipset' не найдена. Установите ipset.", file=sys.stderr)
        sys.exit(1)


def create_ipset(name: str, ipset_type: str):
    """Создает новый ipset список"""
    try:
        subprocess.run(
            ['ipset', 'create', name, ipset_type],
            check=True,
            capture_output=True
        )
        print(f"Создан ipset список '{name}'")
    except subprocess.CalledProcessError as e:
        print(f"Ошибка при создании ipset: {e}", file=sys.stderr)
        if e.stderr:
            print(e.stderr.decode(), file=sys.stderr)
        sys.exit(1)


def flush_ipset(name: str):
    """Очищает ipset список"""
    try:
        subprocess.run(
            ['ipset', 'flush', name],
            check=True,
            capture_output=True
        )
        print(f"Очищен ipset список '{name}'")
    except subprocess.CalledProcessError as e:
        print(f"Ошибка при очистке ipset: {e}", file=sys.stderr)
        if e.stderr:
            print(e.stderr.decode(), file=sys.stderr)
        sys.exit(1)


def add_ips_to_ipset(name: str, ips: Set[str]):
    """Добавляет IP адреса в ipset список в формате $ip,tcp:443"""
    added = 0
    errors = 0

    for ip in sorted(ips):
        entry = f"{ip},tcp:443"
        try:
            result = subprocess.run(
                ['ipset', 'add', name, entry],
                capture_output=True,
                check=False
            )
            if result.returncode == 0:
                added += 1
            else:
                # Игнорируем ошибку, если запись уже существует
                if "already in set" not in result.stderr.decode().lower():
                    print(f"Предупреждение: не удалось добавить {entry}: {result.stderr.decode()}", file=sys.stderr)
                    errors += 1
        except Exception as e:
            print(f"Ошибка при добавлении {entry}: {e}", file=sys.stderr)
            errors += 1

    print(f"Добавлено записей: {added}")
    if errors > 0:
        print(f"Ошибок: {errors}", file=sys.stderr)


def main():
    """Основная функция"""
    print(f"Загрузка IP адресов из {JSON_URL}...")
    ips = load_ips_from_url(JSON_URL)
    print(f"Загружено {len(ips)} уникальных IP адресов")

    # Проверяем существование ipset списка
    if not ipset_exists(IPSET_NAME):
        print(f"Создание ipset списка '{IPSET_NAME}'...")
        create_ipset(IPSET_NAME, IPSET_TYPE)
    else:
        print(f"Очистка существующего ipset списка '{IPSET_NAME}'...")
        flush_ipset(IPSET_NAME)

    # Добавляем IP адреса
    print(f"Добавление IP адресов в ipset список '{IPSET_NAME}'...")
    add_ips_to_ipset(IPSET_NAME, ips)

    # Показываем статистику
    try:
        result = subprocess.run(
            ['ipset', 'list', IPSET_NAME],
            capture_output=True,
            text=True,
            check=True
        )
        lines = result.stdout.split('\n')
        for line in lines:
            if 'Number of entries' in line:
                print(f"\n{line}")
                break
    except subprocess.CalledProcessError:
        pass

    print(f"\nГотово! IPset список '{IPSET_NAME}' обновлен.")


if __name__ == "__main__":
    # Проверяем права root
    if subprocess.run(['id', '-u'], capture_output=True, text=True).stdout.strip() != '0':
        print("Внимание: для работы с ipset требуются права root.", file=sys.stderr)
        print("Запустите скрипт с sudo.", file=sys.stderr)
        sys.exit(1)
    main()
