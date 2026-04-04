# thunderbird

Mail client

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [thunderbird_bwrap_path](#thunderbird_bwrap_path)
  - [thunderbird_gdk_dpi_scale](#thunderbird_gdk_dpi_scale)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### thunderbird_bwrap_path

path to bubblpewraped script

#### Default value

```YAML
thunderbird_bwrap_path: /usr/bin/thunderbird-bubblewrap
```

### thunderbird_gdk_dpi_scale

dpi scale

#### Default value

```YAML
thunderbird_gdk_dpi_scale: '1.0'
```

## Discovered Tags

**_thunderbird_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
