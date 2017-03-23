#!/bin/bash
#git2consul wrapper script
#check if there is a valid consul cluster leader via http endpoint (http://host:port/v1/status/leader) and execute command

while : ; do

	VAR=$(curl --silent --fail http://${CONSUL_ENDPOINT}:8500/v1/status/leader | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

	if [ -n "${VAR}" ]; then
		echo ${VAR} ": cluster leader available"
		break
	else
		echo "no cluster leader available"
		sleep 1
	fi
done

exec /usr/bin/node /usr/lib/node_modules/git2consul ${COMMAND}
