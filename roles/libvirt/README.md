# libvirt

Install libvirt components for KVM

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [libvirt_vms_dir](#libvirt_vms_dir)
- [Discovered Tags](#discovered-tags)
- [Open Tasks](#open-tasks)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### libvirt_vms_dir

#### Default value

```YAML
libvirt_vms_dir: "{{ ansible_user_dir + '/Vms' }}"
```

## Discovered Tags

**_libvirt_**

## Open Tasks

- (improvement): Define in inventory machine list

## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
