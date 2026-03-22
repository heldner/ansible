# uv

Installation uv Python package manager

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [uv_gpg_key_url](#uv_gpg_key_url)
  - [uv_repo_url](#uv_repo_url)
  - [uv_version](#uv_version)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### uv_gpg_key_url

URL GPG ключа репозитория debian.griffo.io

#### Default value

```YAML
uv_gpg_key_url: 
  https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc
```

### uv_repo_url

URL репозитория debian.griffo.io

#### Default value

```YAML
uv_repo_url: https://debian.griffo.io/apt
```

### uv_version

версия пакета uv

#### Default value

```YAML
uv_version: present
```

#### Example usage

```YAML
'present' or 'latest'
```

## Discovered Tags

**_uv_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
