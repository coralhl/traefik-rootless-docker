#!/bin/sh

PUID=${PUID:-1000}
PGID=${PGID:-1000}

### Set the desired timezone
if [ ! -z "$TZ" ]; then
  rm -f /etc/localtime
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
  echo $TZ > /etc/timezone
fi

### Set user
groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

echo '
     ┌                            ┐
                                
       ███ ███ ██████ ███ ███ ███  
      ░███░███░██████░███░███░███  
      ░███████░███░░ ░███░███░███  
      ░░░███░ ░███   ░███░███░███  
       ███████░███   ░███░███░███  
      ░███░███░██████░███░███░███  
      ░███░███░██████░███░███░███  
      ░░░ ░░░ ░░░░░░ ░░░ ░░░ ░░░   
     └                            ┘
           Created by XCIII:
      https://github.com/coralhl/

───────────────────────────────────────'
echo "
PUID                    = $(id -u abc)
PGID                    = $(id -g abc)
───────────────────────────────────────
TZ                      = $TZ
───────────────────────────────────────
"

chown -R abc:abc /etc/traefik/
chown -R abc:abc /var/log/traefik/

### Start traefik
exec su-exec abc /entrypoint.sh "$@"
