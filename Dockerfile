FROM alpine:3.22 AS base
RUN apk add --no-cache \
      build-base cmake clang ca-certificates

FROM base AS tini
ADD https://github.com/krallin/tini.git /build
WORKDIR /build
ENV CC="clang" CFLAGS="-static"
RUN cmake . && \
    make

FROM golang:1.24-alpine AS builder
WORKDIR /build
COPY main.go go.mod go.sum ./
RUN go mod download
ENV CGO_ENABLED=0 GOOS=linux
RUN go build -ldflags="-w -s" -gcflags=all="-l" -o /wg-http-proxy .

FROM scratch
COPY --from=tini /build/tini /sbin/tini
COPY --from=builder /wg-http-proxy /wg-http-proxy
ENTRYPOINT [ "/sbin/tini", "--", "/wg-http-proxy" ]
