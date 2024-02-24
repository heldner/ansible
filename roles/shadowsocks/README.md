# shadowsocks

Install client and server [shadowsocks-libev](https://shadowsocks.org/)

TODO: client configuration

## iptables

ensure that server side has iptables rule:
```shell
iptables -I INPUT -i eth0 -p tcp -m tcp --dport 3128 -m state --state NEW,ESTABLISHED -j ACCEPT
```
