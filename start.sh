#!bin/sh

if [ -z "$CONSUL_IP" ] || [ -z "$CONFIG_URI" ] ; then
    echo "CONSUL_IP and CONFIG_URI must be defined
    exit 1
fi

if [ ! -z $CONFIG_URI ]; then
    wget -O /etc/git2consul.d/config.json $CONFIG_URI 
fi

/usr/lib/node_modules/git2consul --endpoint $CONSUL_IP --port ${CONSUL_PORT:=8500} --config-file /etc/git2consul.d/config.json
