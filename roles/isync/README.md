# isync

Install isync and configure mboxes

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [mbsync_mboxes](#mbsync_mboxes)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### mbsync_mboxes

describe mailboxes

#### Example usage

```YAML
- pass_cmd: "pass mail/mail"
  name: mail
  address: my_mail@domain.com
  imap_server: imap.domain.com
  mboxes:
    - remote_box: "&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-"
      local_box: sent
    - remote_box: "&BBAEQARFBDgEMg-"
      local_box: archive
    - remote_box: "&BBoEPgRABDcEOAQ9BDA-"
      local_box: trash
    - remote_box: "&BCcENQRABD0EPgQyBDgEOgQ4-"
      local_box: drafts
- name: mail2
  pass_cmd: "pass mail/mail2"
  address: my_mail2@domain.com
  imap_server: imap.domain2.com
  mboxes:
    - remote_box: "&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-"
      local_box: sent
    - remote_box: "&BBoEPgRABDcEOAQ9BDA-"
      local_box: trash
    - remote_box: "&BCcENQRABD0EPgQyBDgEOgQ4-"
      local_box: drafts
  auth_mechs: LOGIN (default)
```

## Discovered Tags

**_isync_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
