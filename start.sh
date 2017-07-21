#!bin/sh

if [ -z "$CONSUL_IP" ] || [ -z "$CONFIG_URI" ] || [ -z "$CONFIG_KEY" ]; then
    echo "CONSUL_IP, CONFIG_URI and CONFIG_KEY must be defined"
    exit 1
fi

wget -O /etc/git2consul.d/config.json $CONFIG_URI 

/usr/bin/git2consul \
    --endpoint $CONSUL_IP \
    --port ${CONSUL_PORT:=8500} \
    --config-file /etc/git2consul.d/config.json \
    --config-key git2consul/${CONFIG_KEY}/config
