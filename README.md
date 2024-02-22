# Ansible Collection

Collection for the freedom

## Installation

Create and activate virtual env:
```shell
python3 -m venv .venv
source .venv/bin/activate
```

Install system packages for libvirt-python:
```
apt install libvirt-dev libpython3.11-dev
```

Install requirements:
```shell
pip3 install -r requirements.txt

```

Set path to ansible collection:
```shell
sed -i "s,collections_paths.*,collections_paths = $(realpath ansible_collections)," ansible.cfg
```

## Usefull

Encrypt sensitive data with ansible-vault:

```shell
ansible-vault encrypt_string $string
```

## ansible vault

You can use a script instead of providing the password through an interactive interface.
Save path_to/vault_secret.sh file (add permissions to execute) with the following content:

```shell
#!/bin/bash
echo $password
```

Run ansible:

```shell
ansible-playbook test.yml --vault-password-file path_to/vault_secret.sh
```

