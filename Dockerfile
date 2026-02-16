FROM alpine:latest AS build
RUN apk add --no-cache libsodium-dev build-base autoconf git libbsd-dev
WORKDIR /app
RUN git clone https://github.com/jorisvink/sanctum
WORKDIR /app/sanctum
RUN make
RUN make install

FROM alpine:latest
COPY --from=build /usr/local/bin/ /usr/local/bin
RUN apk add --no-cache doas libsodium doas-sudo-shim
RUN adduser -D sanctum

CMD ["ash", "-c", "syslogd & hymn up && tail -f /var/log/messages"]