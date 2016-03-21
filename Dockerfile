FROM alpine:3.3

ENV VAULT_VERSION=0.4.0 \
    VAULT_SHA256=f56933cb7a445db89f8832016a862ca39b3e63dedb05709251e59d6bb40c56e8
RUN apk add --update ca-certificates wget && \
    wget -O /vault_${VAULT_VERSION}_linux_amd64.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    echo "${VAULT_SHA256}  vault_${VAULT_VERSION}_linux_amd64.zip" > /vault.sha256 && \
    sha256sum -c /vault.sha256 && \
    cd /usr/local/bin && \
    unzip /vault_${VAULT_VERSION}_linux_amd64.zip && \
    apk del ca-certificates wget && \
    rm -rfv /vault* /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/vault"]
