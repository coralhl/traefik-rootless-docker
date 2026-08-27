# traefik rootless

[Traefik Image](https://github.com/traefik/traefik-library-image) rootless docker image Alpine based.

Works only with [docker-socket-proxy](https://github.com/Tecnativa/docker-socket-proxy)

docker-compose.yml

```yaml
services:
  traefik-proxy:
    image: coralhl/traefik-rootless:v3
    container_name: traefik
    restart: always
    security_opt:
      - no-new-privileges:true
    environment:
      - TZ=Europe/Moscow
      - PUID=1000
      - PGID=1000
    volumes:
      - /path/to/traefik/logs/:/var/log/traefik/
      - /path/to/traefik/conf/:/etc/traefik/
      - /path/to/traefik/plugins/:/plugins-storage/
    labels:
      - "traefik.enable=true"
      - ...
    networks:
      traefik:
    ports:
      - 80:80
      - 443:443
    depends_on:
      - traefik-dockersocket

  traefik-dockersocket:
    image: tecnativa/docker-socket-proxy
    container_name: traefik-dockersocket
    restart: always
    privileged: true
    environment:
      - CONTAINERS=1
      - POST=0
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      traefik:
```
