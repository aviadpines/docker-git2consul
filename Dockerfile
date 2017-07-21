FROM alpine:3.6.2
MAINTAINER Aviad Pines (Forked from Calvin Leung Huang <https://github.com/calvn>)

CONSUL_PORT=8500
if [ -z "$CONSUL_IP" ] || [ -z "$CONFIG_URI" ] ; then
    echo "CONSUL_IP and CONFIG_URI must be defined
    exit 1
fi

RUN apk --update add nodejs git openssh ca-certificates wget && \
    rm -rf /var/cache/apk/* && \
    npm install git2consul@0.12.13 --global && \
    mkdir -p /etc/git2consul.d

if [ ! -z $CONFIG_URI ]; then
    wget -O /etc/git2consul.d/config.json $CONFIG_URI 
fi

ENTRYPOINT [ "/usr/bin/node", "/usr/lib/node_modules/git2consul" ]
CMD --endpoint $CONSUL_IP --port ${CONSUL_PORT:=8500} --config-file /etc/git2consul.d/config.json
