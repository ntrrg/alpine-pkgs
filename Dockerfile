FROM alpine:3.13
ARG NEW_USER="ntrrg"
ARG MIRROR="http://dl-cdn.alpinelinux.org/alpine/v3.13"
RUN \
  echo "$MIRROR/main" > /etc/apk/repositories && \
  echo "$MIRROR/community" >> /etc/apk/repositories && \
  apk add --no-cache alpine-sdk atools sudo && \
  adduser -D "$NEW_USER" && \
  addgroup "$NEW_USER" abuild && \
  echo "$NEW_USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR "/home/$NEW_USER/pkgs"
COPY . .
RUN chown -R "$NEW_USER":"$NEW_USER" .
USER "$NEW_USER"
VOLUME /home/$NEW_USER/.abuild
VOLUME /var/cache/distfiles
VOLUME /home/$NEW_USER/packages
ENTRYPOINT ["./entrypoint.sh"]

