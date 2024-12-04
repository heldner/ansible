# freshrss

Install [freshrss](https://www.freshrss.org/)

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [freshrss_home](#freshrss_home)
  - [freshrss_update_day_of_month](#freshrss_update_day_of_month)
  - [freshrss_update_day_of_week](#freshrss_update_day_of_week)
  - [freshrss_update_hour](#freshrss_update_hour)
  - [freshrss_update_min](#freshrss_update_min)
  - [freshrss_update_month](#freshrss_update_month)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.12`

## Default Variables

### freshrss_home

freshrss deploy directory

#### Default value

```YAML
freshrss_home: test
```

### freshrss_update_day_of_month

#### Default value

```YAML
freshrss_update_day_of_month: '*'
```

### freshrss_update_day_of_week

#### Default value

```YAML
freshrss_update_day_of_week: '*'
```

### freshrss_update_hour

#### Default value

```YAML
freshrss_update_hour: '*'
```

### freshrss_update_min

#### Default value

```YAML
freshrss_update_min: '*/30'
```

### freshrss_update_month

#### Default value

```YAML
freshrss_update_month: '*'
```

## Discovered Tags

**_freshrss_**


## Dependencies

None.

## License

ISC

## Author

Stanislav Korolev
