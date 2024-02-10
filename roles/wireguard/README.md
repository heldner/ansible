Wireguard
=========

Configure wiregurad vpn client and server side.

Requirements
------------

Server

Role Variables
--------------
wg_peers - need to be defined

    wg_peers:
      - pubkey: '9kwJORqKmbPHkuldlhRHCnGkBCrKT563J3u+TYStumQ='
        allowed_ips:  '192.168.41.34/32'

License
-------

ISC
