ARG target

FROM alpine:3.8 as certs
# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates

FROM $target/alpine:3.8
LABEL maintainer="Paul Canham <paul@canham.io>"
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY tiller /tiller

EXPOSE 44134
USER nobody
ENTRYPOINT ["/tiller"]
