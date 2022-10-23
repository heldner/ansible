# Syncthing

Установка и настройка утилиты для синхронизации данных [syncthing](https://syncthing.net/)

Пример получения device id из json

```yaml
- name: Fetch device id
  set_fact:
    _syncthing_device_id: "{{ _syncthing_config_raw.json
      | json_query(jmesquery) }}"
  vars:
    jmesquery: "devices[?name=='{{ ansible_hostname }}'].deviceID"
```
