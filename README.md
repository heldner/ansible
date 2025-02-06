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

Install ansible-galaxy requirements
```shell
ansible-galaxy install -r requirements-galaxy.yml
```

## vault

You can use a script to provide vault password.
Save `path_to/vault_secret.sh` file (add permissions to execute) with the following content:

```shell
#!/bin/bash
echo $password
```

Run ansible:

```shell
ansible-playbook test.yml --vault-password-file path_to/vault_secret.sh
```

### tips

Encrypt sensitive data with ansible-vault:

```shell
ansible-vault encrypt_string $string -n fredsSecretString
```
