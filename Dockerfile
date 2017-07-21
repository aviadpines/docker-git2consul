FROM alpine:3.6
MAINTAINER Aviad Pines (Forked from Calvin Leung Huang <https://github.com/calvn>)

ADD start.sh .

RUN apk --update add nodejs nodejs-npm git openssh ca-certificates && \
    rm -rf /var/cache/apk/* && \
    npm install git2consul@0.12.13 --global && \
    mkdir -p /etc/git2consul.d

CMD start.sh
