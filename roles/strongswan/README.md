# strongswan

Install and configure IPsec VPN [strongswan](https://strongswan.org/) with IKEv2 support.
## Usage
- Connect: `sudo swanctl -i -c home`
- Disconnect: `sudo swanctl -t home` or `sudo swanctl -t --all`
- List connections: `sudo swanctl --list-conns` or `sudo swanctl -L`
- List active SAs: `sudo swanctl --list-sas` or `sudo swanctl -l`
- Load config: `sudo swanctl --load-all` or `sudo swanctl -q`


## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [strongswan_local_id](#strongswan_local_id)
  - [strongswan_password](#strongswan_password)
  - [strongswan_remote_id](#strongswan_remote_id)
  - [strongswan_remote_ts](#strongswan_remote_ts)
  - [strongswan_server](#strongswan_server)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### strongswan_local_id

локальный идентификатор для подключения

### strongswan_password

пароль для подключения к VPN

### strongswan_remote_id

удаленный идентификатор сервера

#### Default value

```YAML
strongswan_remote_id: '{{ strongswan_server }}'
```

### strongswan_remote_ts

целевая сеть для маршрутизации через VPN

#### Default value

```YAML
strongswan_remote_ts: 10.0.0.0/8
```

### strongswan_server

адрес VPN сервера для подключения

#### Default value

```YAML
strongswan_server: v.kinescope.io
```

## Discovered Tags

**_strongswan_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
