# Interfaces

Заполнение файла /etc/network/interfaces. Без поднятия интерфейсов.

## Необходимые пакеты
Для работы bongind необходимо установить пакет ifenslave. Для работы vlan необходимо установить пакет vlan.

## Применение плейбука для wdc-compute-6:
```
ansible-playbook -u root -i wdc-compute-6, -e location=wdc -e hosts=all --diff anyrole.yml -e target_role=interfaces -e ansible_host=207.244.100.102
```
## Пример настройки обычного сетевого интерфейса:
Добавить в host_vars машины:
```
---
interfaces:
  - name:      em49
    address:   209.58.134.229
    netmask:   255.255.255.224
    network:   209.58.134.224
    broadcast: 209.58.134.255
    gateway:   209.58.134.254
```

## Пример настройки обычного bonding интерфейса:
Добавить в host_vars машины:
```
interfaces:
  - name: em49
    mode: manual
    bond_master: bond0
  - name: em50
    mode: manual
    bond_master: bond0
  - name: bond0
    mode: static
    bond_mode: 4
    bond_miimon: 100
    bond_lacp_rate: 1
    bond_slaves: em49 em50
    address: 10.6.10.102
    netmask: 255.255.255.0
    gateway: 10.6.10.1
```

## Пример настройки bonding интерфейса с двумя vlan-id 72 и 73:
Добавить в host_vars машины:
```
interfaces:
  - name: em1
    mode: manual
    bond_master: bond0
  - name: em2
    mode: manual
    bond_master: bond0
  - name: bond0
    mode: manual
    bond_mode: 4
    bond_miimon: 100
    bond_lacp_rate: 1
    bond_slaves: em1 em2
  - name: bond0.72
    mode: static
    address: 118.62.50.245
    netmask: 255.255.255.0
    gateway: 118.62.50.1
    vlan-raw-device: bond0
  - name: bond0.73
    mode: static
    address: 10.7.244.12
    netmask: 255.255.255.0
    gateway: 10.7.244.1
    vlan-raw-device: bond0
```