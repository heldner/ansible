# chatwoot

Install [Chatwoot](https://www.chatwoot.com/) from the official Debian package repository.

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [chatwoot_package_name](#chatwoot_package_name)
  - [chatwoot_package_state](#chatwoot_package_state)
  - [chatwoot_package_version](#chatwoot_package_version)
  - [chatwoot_apt_repo](#chatwoot_apt_repo)
  - [chatwoot_apt_distribution](#chatwoot_apt_distribution)
  - [chatwoot_apt_key_url](#chatwoot_apt_key_url)
  - [chatwoot_apt_keyring_path](#chatwoot_apt_keyring_path)
  - [chatwoot_apt_list_filename](#chatwoot_apt_list_filename)
  - [chatwoot_apt_prereq_packages](#chatwoot_apt_prereq_packages)
  - [chatwoot_manage_env](#chatwoot_manage_env)
  - [chatwoot_env_file](#chatwoot_env_file)
  - [chatwoot_env_owner](#chatwoot_env_owner)
  - [chatwoot_env_group](#chatwoot_env_group)
  - [chatwoot_env_mode](#chatwoot_env_mode)
  - [chatwoot_env](#chatwoot_env)
  - [chatwoot_services](#chatwoot_services)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`
- Debian-based target with systemd and apt

## Default Variables

### chatwoot_package_name

Name of the Debian package that provides Chatwoot.

#### Default value

```YAML
chatwoot_package_name: chatwoot
```

### chatwoot_package_state

Desired state for the Chatwoot package.

#### Default value

```YAML
chatwoot_package_state: present
```

### chatwoot_package_version

Optional specific version to install (`''` means latest available).

#### Default value

```YAML
chatwoot_package_version: ''
```

### chatwoot_apt_repo

Base URL of the Chatwoot apt repository.

#### Default value

```YAML
chatwoot_apt_repo: https://apt.chatwoot.app/
```

### chatwoot_apt_distribution

Distribution component that apt should track for Chatwoot.

#### Default value

```YAML
chatwoot_apt_distribution: ./
```

### chatwoot_apt_key_url

URL to the GPG key used to sign the Chatwoot repository.

#### Default value

```YAML
chatwoot_apt_key_url: https://apt.chatwoot.app/key.gpg
```

### chatwoot_apt_keyring_path

Location on disk where the Chatwoot key is stored.

#### Default value

```YAML
chatwoot_apt_keyring_path: /usr/share/keyrings/chatwoot-archive-keyring.gpg
```

### chatwoot_apt_list_filename

Filename used in `/etc/apt/sources.list.d/` for the Chatwoot repository.

#### Default value

```YAML
chatwoot_apt_list_filename: chatwoot
```

### chatwoot_apt_prereq_packages

List of packages required before adding the Chatwoot repository.

#### Default value

```YAML
chatwoot_apt_prereq_packages:
  - apt-transport-https
  - ca-certificates
  - gnupg
  - curl
```

### chatwoot_manage_env

Whether the role should manage the Chatwoot `.env` file.

#### Default value

```YAML
chatwoot_manage_env: true
```

### chatwoot_env_file

Absolute path to the Chatwoot environment file.

#### Default value

```YAML
chatwoot_env_file: /opt/chatwoot/.env
```

### chatwoot_env_owner

User that should own the Chatwoot environment file.

#### Default value

```YAML
chatwoot_env_owner: chatwoot
```

### chatwoot_env_group

Group that should own the Chatwoot environment file.

#### Default value

```YAML
chatwoot_env_group: chatwoot
```

### chatwoot_env_mode

Filesystem mode applied to the Chatwoot environment file.

#### Default value

```YAML
chatwoot_env_mode: '0640'
```

### chatwoot_env

Dictionary of key/value pairs rendered into the `.env` file.

#### Default value

```YAML
chatwoot_env: {}
```

### chatwoot_services

Systemd services restarted when Chatwoot is updated or reconfigured.

#### Default value

```YAML
chatwoot_services:
  - chatwoot.target
```

## Discovered Tags

**_chatwoot_**

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
