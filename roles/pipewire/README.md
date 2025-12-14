# pipewire

Install and configure pipewire

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [pipewire_wireplumber_config_dir](#pipewire_wireplumber_config_dir)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### pipewire_wireplumber_config_dir

директория с конфигами wireplumber

#### Default value

```YAML
pipewire_wireplumber_config_dir: '{{ ansible_user_dir }}/.config/wireplumber/wireplumber.conf.d'
```

## Discovered Tags

**_config_**

**_install_**

**_pipewire_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
