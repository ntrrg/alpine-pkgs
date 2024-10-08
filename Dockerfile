FROM alpine:edge
ARG NEW_USER="ntrrg"
ARG MIRROR="http://dl-cdn.alpinelinux.org/alpine/edge"
RUN \
  echo "$MIRROR/main" > /etc/apk/repositories && \
  echo "$MIRROR/community" >> /etc/apk/repositories && \
  echo "@testing $MIRROR/testing" >> /etc/apk/repositories && \
  apk add --no-cache alpine-sdk atools doas && \
  adduser -D "$NEW_USER" && \
  addgroup "$NEW_USER" abuild && \
  echo "permit nopass $NEW_USER as root" >> /etc/doas.conf
WORKDIR "/home/$NEW_USER/pkgs"
COPY . .
RUN \
  mkdir "/home/$NEW_USER/packages" && \
  chown -R "$NEW_USER":"$NEW_USER" "/home/$NEW_USER"
USER "$NEW_USER"
VOLUME /home/$NEW_USER/.abuild
VOLUME /var/cache/distfiles
VOLUME /home/$NEW_USER/packages
ENTRYPOINT ["./entrypoint.sh"]

