# apt

Configure apt repos and params

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [apt_mirror](#apt_mirror)
  - [apt_unattended_upgrade_remove_new_unused_dependencies](#apt_unattended_upgrade_remove_new_unused_dependencies)
  - [apt_unattended_upgrade_remove_unused_dependencies](#apt_unattended_upgrade_remove_unused_dependencies)
  - [apt_unattended_upgrade_remove_unused_kernel_packages](#apt_unattended_upgrade_remove_unused_kernel_packages)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.1`

## Default Variables

### apt_mirror

#### Default value

```YAML
apt_mirror: http://mirror.yandex.ru/debian/
```

### apt_unattended_upgrade_remove_new_unused_dependencies

#### Default value

```YAML
apt_unattended_upgrade_remove_new_unused_dependencies: true
```

### apt_unattended_upgrade_remove_unused_dependencies

#### Default value

```YAML
apt_unattended_upgrade_remove_unused_dependencies: true
```

### apt_unattended_upgrade_remove_unused_kernel_packages

#### Default value

```YAML
apt_unattended_upgrade_remove_unused_kernel_packages: true
```

## Discovered Tags

**_apt_**

**_cron_**

**_unattended_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
