# kitty

Install and configure kitty terminal emulator

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [kitty_home](#kitty_home)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### kitty_home

директория с конфигами kitty

#### Default value

```YAML
kitty_home: '{{ ansible_user_dir }}/.config/kitty'
```

## Discovered Tags

**_kitty_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
