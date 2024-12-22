# goimapnotify

install goimapnotify as user systemd service

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [goimapnotify_deb_version](#goimapnotify_deb_version)
  - [goimapnotify_mboxes](#goimapnotify_mboxes)
  - [goimapnotify_version](#goimapnotify_version)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### goimapnotify_deb_version

#### Default value

```YAML
goimapnotify_deb_version: '{{ goimapnotify_version }}-2'
```

### goimapnotify_mboxes

hashmap with configuration

### goimapnotify_version

#### Default value

```YAML
goimapnotify_version: 2.4
```

## Discovered Tags

**_goimapnotify_**


## Dependencies

- package_facts

## License

ISC

## Author

Stanislav Korolev
