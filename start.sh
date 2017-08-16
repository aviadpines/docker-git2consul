#!bin/sh

if [ -z "$CONSUL_IP" ] || [ -z "$CONFIG_KEY" ]; then
    echo "CONSUL_IP and CONFIG_KEY must be defined"
    exit 1
fi

if [ "$CONFIG_LOCAL" = true  ]; then
  echo "using local config"
  if [ ! -z "$CONFIG_ENV"  ]; then
    cat <<-EOF > /etc/git2consul.d/config.json
	{
	  "version": "1.0",
 	  "repos" : [
	    {
	      "branches": [ "master" ],
	      "expand_keys": true,
	      "hooks": [
	        {
	          "interval": 1,
	          "type": "polling"
	         }
	      ],
	      "source_root": "configurations",
	      "ignore_file_extension": true,
	      "include_branch_name": false,
	      "name": "${CONFIG_ENV}/config",
	      "url": "https://git-codecommit.us-west-2.amazonaws.com/v1/repos/services-configuration"
	    }
	  ]
	}
	EOF
  else
    echo "CONFIG_LOCAL is defined but CONFIG_ENV is not"
  fi
elif  [ ! -z "$CONFIG_URI" ]; then
  # fetch configuration from config uri
  wget -O /etc/git2consul.d/config.json $CONFIG_URI 
else
  echo "could not parse configuration. CONFIG_LOCAL=$CONFIG_LOCAL, CONFIG_ENV=$CONFIG_ENV, CONFIG_URI=$CONFIG_URI"
fi

/usr/bin/git2consul \
  --endpoint $CONSUL_IP \
  -c git2consul/${CONFIG_KEY}/config \
  --port ${CONSUL_PORT:=8500} \
  --config-file /etc/git2consul.d/config.json 
