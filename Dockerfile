FROM alpine:3.6
MAINTAINER marcelo correia <marcelo@correia.io>
ARG version="0.9.0"
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --no-cache --update \
    curl \
    unzip \
    bash \
    python \
    py-pip \
    git \
    openssh \
    make \
    jq
RUN apk add --update tzdata
RUN pip install --upgrade pip
RUN pip install awscli
RUN curl https://releases.hashicorp.com/vault/${version}/vault_${version}_linux_amd64.zip -o vault_${version}_linux_amd64.zip
RUN unzip vault_${version}_linux_amd64.zip -d /usr/local/bin
RUN mkdir -p /opt/workspace
RUN rm /var/cache/apk/*

WORKDIR /opt/workspace
CMD vault version
