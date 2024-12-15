# forgejo

Install [forgejo](https://forgejo.org)

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [forgejo_deb_version](#forgejo_deb_version)
  - [forgejo_version](#forgejo_version)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### forgejo_deb_version

#### Default value

```YAML
forgejo_deb_version: '{{ forgejo_version }}-2'
```

### forgejo_version

#### Default value

```YAML
forgejo_version: 9.0.3
```

## Discovered Tags

**_forgejo_**


## Dependencies

- package_facts

## License

ISC

## Author

Stanislav Korolev
