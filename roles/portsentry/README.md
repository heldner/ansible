# portsentry

Portsentry https://github.com/portsentry/portsentry is a tool to detect and respond to port scans against a target host in real-time.

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [portsentry_block_tcp](#portsentry_block_tcp)
  - [portsentry_block_udp](#portsentry_block_udp)
  - [portsentry_tcp_ports](#portsentry_tcp_ports)
  - [portsentry_udp_ports](#portsentry_udp_ports)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### portsentry_block_tcp

1 - block, 0 - not block iptables if detect tcp scans

#### Default value

```YAML
portsentry_block_tcp: 1
```

### portsentry_block_udp

1 - block, 0 - not block iptables if detect udp scans

#### Default value

```YAML
portsentry_block_udp: 1
```

### portsentry_tcp_ports

comma separated list of listening tcp ports

#### Default value

```YAML
portsentry_tcp_ports: 
  1,11,15,79,111,119,143,540,635,1080,1524,2000,5742,6667,12345,12346,20034,27665,31337,32771,32772,32773,32774,40421,49724,54320
```

### portsentry_udp_ports

comma separated list of listening tcp ports

#### Default value

```YAML
portsentry_udp_ports: 
  1,7,9,69,161,162,513,635,640,641,700,37444,34555,31335,32770,32771,32772,32773,32774,31337,54321
```

## Discovered Tags

**_portsentry_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
