# etesync_dav

Install EteSync-DAV binary from GitHub releases and user systemd service

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [_etesync_dav_arch_map](#_etesync_dav_arch_map)
  - [_etesync_dav_current_arch](#_etesync_dav_current_arch)
  - [_etesync_dav_url](#_etesync_dav_url)
  - [etesync_dav_binary_path](#etesync_dav_binary_path)
  - [etesync_dav_enable_linger](#etesync_dav_enable_linger)
  - [etesync_dav_enable_service](#etesync_dav_enable_service)
  - [etesync_dav_version](#etesync_dav_version)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### _etesync_dav_arch_map

#### Default value

```YAML
_etesync_dav_arch_map:
  x86_64:
    zip: dist-ubuntu-latest.zip
    bin: linux-amd64-etesync-dav
  aarch64:
    zip: dist-ubuntu-22.04-arm.zip
    bin: linux-arm64-etesync-dav
```

### _etesync_dav_current_arch

#### Default value

```YAML
_etesync_dav_current_arch: '{{ _etesync_dav_arch_map[ansible_architecture] }}'
```

### _etesync_dav_url

#### Default value

```YAML
_etesync_dav_url: https://github.com/etesync/etesync-dav/releases/download/v{{ 
  etesync_dav_version }}/{{ _etesync_dav_current_arch.zip }}
```

### etesync_dav_binary_path

install path for the executable (same as upstream wiki, e.g. /usr/local/bin)

#### Default value

```YAML
etesync_dav_binary_path: /usr/local/bin/etesync-dav
```

### etesync_dav_enable_linger

enable systemd linger for the user so the service can start before graphical login

#### Default value

```YAML
etesync_dav_enable_linger: false
```

### etesync_dav_enable_service

enable and start the etesync-dav user systemd unit

#### Default value

```YAML
etesync_dav_enable_service: true
```

### etesync_dav_version

release version without the v prefix (GitHub release tag, e.g. 0.35.1)

#### Default value

```YAML
etesync_dav_version: 0.35.1
```

## Discovered Tags

**_etesync_dav_**

**_install_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
