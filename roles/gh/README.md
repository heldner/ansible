# gh

Installation GitHub CLI

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [gh_arch_map](#gh_arch_map)
  - [gh_version](#gh_version)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### gh_arch_map

маппинг архитектуры Ansible на архитектуру Debian пакетов

#### Default value

```YAML
gh_arch_map:
  x86_64: amd64
  aarch64: arm64
  armv7l: armhf
```

### gh_version

Package version gh

#### Default value

```YAML
gh_version: present
```

#### Example usage

```YAML
'present' or 'latest'
```

## Discovered Tags

**_gh_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
