#!/usr/bin/env python3

class FilterModule(object):
    def filters(self):
        return {
            'set_flags': self.set_flags
        }

    def set_flags(self, input_text):
        set_type = input_text.split()[0] if input_text else ''
        flags = {
            'hash:net': 'src',
            'hash:net,port': 'src,dst',
            'bitmap:port': 'dst',
        }
        if set_type not in flags:
            raise ValueError(
                f"Unknown ipset type '{set_type}' (from '{input_text}'). "
                f"Supported types: {', '.join(flags)}"
            )
        return flags[set_type]
