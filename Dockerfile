FROM alpine:latest AS build
RUN apk add --no-cache libsodium-dev build-base autoconf git libbsd-dev
WORKDIR /app
RUN git clone https://github.com/jorisvink/sanctum
WORKDIR /app/sanctum
RUN make
RUN make install

FROM alpine:latest
COPY --from=build /usr/local/bin/ /usr/local/bin
RUN apk add --no-cache doas libsodium doas-sudo-shim tini
RUN adduser -D sanctum
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["tini", "--"]
CMD ["/docker-entrypoint.sh"]