# iptables

Configure iptables and ipset ![iptables default flow](iptables.svg)


## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [ipset_config_file](#ipset_config_file)
  - [ipset_tables](#ipset_tables)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.16`

## Default Variables

### ipset_config_file

location with ipset rules

#### Default value

```YAML
ipset_config_file: /etc/ipset.tables
```

### ipset_tables

#### Example usage

```YAML
ipset_tables:
  - name: portsentry_tcp
    set_option: bitmap:port range 0-65535
    items:
      - 111
      - 123
```

## Discovered Tags

**_iptables_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
