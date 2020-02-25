# find interfaces with MAC-Addresses only (No IP):

Cmd: **ip link**
```
(?i)[0-9]: +(.+):.*state +(UP|UNKNOWN).*\n.*link/(.+?) +(([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2})
```
