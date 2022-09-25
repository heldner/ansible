Wireguard
=========

Configure wiregural vpn in OpenBSD.

Requirements
------------

All you need is OpenBSD version higher than 6.8

Role Variables
--------------
wg_peers - need to be defined

    wg_peers:
      - pubkey: '9kwJORqKmbPHkuldlhRHCnGkBCrKT563J3u+TYStumQ='
        allowed_ips:  '192.168.41.34/32'

License
-------

ISC
