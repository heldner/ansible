# gnupg

Install and configure command line gpg tool with agent.

## usage

https://keys.openpgp.org/about/usage

### retrive key

To locate the key of a user, by email address:

```sh
gpg --auto-key-locate keyserver --locate-keys user@example.net
```

To refresh all your keys (e.g. new revocation certificates and subkeys):

```sh
gpg --refresh-keys
```

### upload key

Keys can be uploaded with GnuPG's --send-keys command, but identity information
can't be verified that way to make the key searchable by email address

```sh
gpg --export your_address@example.net | curl -T - https://keys.openpgp.org
```
