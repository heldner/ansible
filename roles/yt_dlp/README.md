# yt_dlp

Install yt-dlp via uv into a virtual environment

## Table of contents

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [yt_dlp_bin_dir](#yt_dlp_bin_dir)
  - [yt_dlp_venv_dir](#yt_dlp_venv_dir)
  - [yt_dlp_version](#yt_dlp_version)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### yt_dlp_bin_dir

directory for the yt-dlp symlink

#### Default value

```YAML
yt_dlp_bin_dir: '{{ ansible_user_dir }}/.local/bin'
```

### yt_dlp_venv_dir

yt-dlp virtual environment directory

#### Default value

```YAML
yt_dlp_venv_dir: '{{ ansible_user_dir }}/.local/share/yt-dlp'
```

### yt_dlp_version

yt-dlp version to install

#### Default value

```YAML
yt_dlp_version: ''
```

#### Example usage

```YAML
'2025.3.31' or empty string for latest
```

## Discovered Tags

**_yt_dlp_**

## Dependencies

- uv

## License

ISC

## Author

Stanislav Korolev
