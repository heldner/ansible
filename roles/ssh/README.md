# ssh

Install ssh client, server and configure it

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [ssh_hosts](#ssh_hosts)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### ssh_hosts

#### Default value

```YAML
ssh_hosts: "{{ lookup('community.general.merge_variables', '__ssh_hosts', pattern_type='suffix')
  }}"
```

## Discovered Tags

**_ssh_**

**_ssh_client_**

**_ssh_proxies_**

**_ssh_server_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
