
# docker-nginx-proxy

A Docker container for running nginx proxy with support for backups, based on [Alpine Linux](https://alpinelinux.org/).

## Quick start

Requires that [Docker be installed](https://docs.docker.com/engine/installation/) on the host machine.

```
$ docker run --name nginx -d \
   -e "APP_HOST_PORT=http://app:8080"
   --publish 80:80
   tiberiuc/nginx_proxy

$ docker logs -f nginx
[ ... ]
```

