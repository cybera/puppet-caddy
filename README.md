Opinionated Puppet Module for deploying Caddy as a reverse proxy

## Usage

```
include caddy
```

This will install the latest version by default.

### Hiera
```
caddy::version: 'latest'

caddy::reverse_proxies:
  NAME:
    local_port: 8080
    external_port: 80
```

