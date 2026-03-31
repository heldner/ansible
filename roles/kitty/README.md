# kitty

Install and configure kitty terminal emulator

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [kitty_font_size](#kitty_font_size)
  - [kitty_home](#kitty_home)
  - [kitty_scrollback_lines](#kitty_scrollback_lines)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### kitty_font_size

font size

#### Default value

```YAML
kitty_font_size: 15.0
```

### kitty_home

config directory

#### Default value

```YAML
kitty_home: '{{ ansible_user_dir }}/.config/kitty'
```

### kitty_scrollback_lines

scroll lines

#### Default value

```YAML
kitty_scrollback_lines: 10000
```

## Discovered Tags

**_kitty_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
