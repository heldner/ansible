# git

Install git packages add copy .gitconfig

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [git_custom_configs](#git_custom_configs)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### git_custom_configs

list with custom git prefernces for spicific repositories
uses [includeIf](https://git-scm.com/docs/git-config)

#### Example usage

```YAML
git_custom_configs:
  - name: pass
    email: my@email.com
    config_name: kinescope
    gpg_sign: true
    gitdir: ~/.password-store/
```

## Discovered Tags

**_git_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
