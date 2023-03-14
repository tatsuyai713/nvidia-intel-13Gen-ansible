#!/bin/bash

sudo apt update
sudo apt install -y ansible

if [ ! $# -ne 1 ]; then
	if [ "localhost" = $1 ]; then
		ansible-playbook -i ./ansible/inventories/hosts.yml ./ansible/localhost.yml
	elif [ "docker" = $1 ]; then

		if [ ! -e ~/.ssh/id_rsa.pub  ]; then
			ssh-keygen -t rsa
		fi
		ssh-copy-id -i ~/.ssh/id_rsa.pub 172.17.0.2
		ansible-playbook -i ./ansible/inventories/hosts.yml ./ansible/docker.yml

	fi
else
	echo "Plese select and add local or docker."
fi
