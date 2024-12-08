# findmydeviceserver

install mpd as user systemd service

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [findmydeviceserver_socket](#findmydeviceserver_socket)
  - [findmydeviceserver_version](#findmydeviceserver_version)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.16`

## Default Variables

### findmydeviceserver_socket

unix socket path where fmd listen

#### Default value

```YAML
findmydeviceserver_socket: /dev/shm/fmd.sock
```

### findmydeviceserver_version

version of fmd

#### Default value

```YAML
findmydeviceserver_version: 0.8.0
```

## Discovered Tags

**_findmydeviceserver_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
