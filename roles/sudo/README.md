# sudo

install mpd as user systemd service

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [sudo_nopass_cmds](#sudo_nopass_cmds)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### sudo_nopass_cmds

список пользователей и команд для выполнения без пароля

#### Default value

```YAML
sudo_nopass_cmds: []
```

#### Example usage

```YAML
  - user: myuser
    cmds:
      - /usr/bin/systemctl
      - /usr/bin/docker
  - user: anotheruser
    cmds:
      - /usr/bin/apt
```

## Discovered Tags

**_nopass_cmds_**

**_sudo_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
