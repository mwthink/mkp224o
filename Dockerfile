FROM alpine:3.9 as builder
RUN apk add --no-cache alpine-sdk autoconf libsodium-dev

WORKDIR /src
COPY . .

RUN \
  ./autogen.sh && \
  ./configure --enable-donna && \
  make

FROM alpine:3.9
RUN apk add --no-cache libsodium
COPY --from=builder /src/mkp224o /
ENTRYPOINT ["/mkp224o"]
