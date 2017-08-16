FROM alpine:3.6
MAINTAINER Aviad Pines (Forked from Calvin Leung Huang <https://github.com/calvn>)

ADD start.sh /start.sh
RUN chmod +x /start.sh

RUN apk --update add nodejs nodejs-npm git openssh ca-certificates openssl groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm -rf /var/cache/apk/* && \
    npm install git2consul@0.12.13 --global && \
    mkdir -p /etc/git2consul.d

CMD [ "/start.sh" ]
