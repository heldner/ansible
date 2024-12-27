# unbound

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [access_control](#access_control)
  - [default_forward_addresses](#default_forward_addresses)
  - [unbound_interface](#unbound_interface)
  - [unbound_port](#unbound_port)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

None.

## Default Variables

### access_control

#### Default value

```YAML
access_control:
  - 127.0.0.1/32 allow_snoop
  - ::1 allow_snoop
```

### default_forward_addresses

#### Default value

```YAML
default_forward_addresses:
  - 1.1.1.1@853
  - 1.0.0.1@853
  - 9.9.9.9@853
  - 149.112.112.112@853
```

### unbound_interface

#### Default value

```YAML
unbound_interface: 0.0.0.0
```

### unbound_port

#### Default value

```YAML
unbound_port: 53
```

## Discovered Tags

**_unbound_**


## Dependencies

None.
