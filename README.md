# Ansible Collection

Collection for the freedom

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

