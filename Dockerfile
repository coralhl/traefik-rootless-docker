FROM --platform=$BUILDPLATFORM traefik:3.7.11

# Copy tools
COPY start.sh /start.sh

# Update image & install packages
RUN set -ex \
    && apk update \
    && apk add --no-cache \
      libcap \
      shadow \
      su-exec \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* /usr/src/* \
    && setcap 'cap_net_bind_service=+ep' /usr/local/bin/traefik \
    && addgroup -g 1000 abc \
    && adduser -D -u 1000 -G abc abc \
    && chmod +x /start.sh

# Let's start traefik
ENTRYPOINT ["/start.sh"]
CMD ["traefik"]
