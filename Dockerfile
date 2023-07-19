FROM alpine:edge
ARG NEW_USER="ntrrg"
ARG MIRROR="http://dl-cdn.alpinelinux.org/alpine/edge"
RUN \
  echo "$MIRROR/main" > /etc/apk/repositories && \
  echo "$MIRROR/community" >> /etc/apk/repositories && \
  echo "@testing $MIRROR/testing" >> /etc/apk/repositories && \
  apk add --no-cache alpine-sdk atools doas sudo && \
  adduser -D "$NEW_USER" && \
  addgroup "$NEW_USER" abuild && \
  echo "$NEW_USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  echo "permit nopass $NEW_USER as root" >> /etc/doas.conf && \
  sudo true
WORKDIR "/home/$NEW_USER/pkgs"
COPY . .
RUN chown -R "$NEW_USER":"$NEW_USER" .
USER "$NEW_USER"
VOLUME /home/$NEW_USER/.abuild
VOLUME /var/cache/distfiles
VOLUME /home/$NEW_USER/packages
ENTRYPOINT ["./entrypoint.sh"]

