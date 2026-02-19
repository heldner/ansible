# sthp

Запуск sthp как пользовательский systemd юнит

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [sthp_bin](#sthp_bin)
  - [sthp_port](#sthp_port)
  - [sthp_socks_porxy](#sthp_socks_porxy)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### sthp_bin

путь к исполняемому файлу sthp

#### Default value

```YAML
sthp_bin: '{{ ansible_user_dir }}/.local/bin/sthp'
```

### sthp_port

порт на котором слушает http прокси

#### Default value

```YAML
sthp_port: 1085
```

### sthp_socks_porxy

адрес socks5 прокси

#### Default value

```YAML
sthp_socks_porxy: 127.0.0.1:5832
```

## Discovered Tags

**_sthp_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
