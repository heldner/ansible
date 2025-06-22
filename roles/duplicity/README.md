# duplicity

Encrypted backups with duplicity
with usage of gpg-agent


## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [duplicity_gpg_key](#duplicity_gpg_key)
  - [duplicity_targets](#duplicity_targets)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### duplicity_gpg_key

public gpg key

### duplicity_targets

hosts list with item.src item.dest

#### Example usage

```YAML
duplicity_targets:
  - dest: file:///home/$USER/Backups/thunerbird.duplicity
    src: /home/$USER/.thunderbird
  - dest: sftp:///rootit/home/$USER/Backups/thunerbird.duplicity
    src: /home/$USER/.thunderbird
    full_if_older_than: 1M
```

## Discovered Tags

**_duplicity_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
