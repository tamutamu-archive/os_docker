#!/bin/bash

base_name=os_centos7
port=2222

rm -f ${base_name} ${base_name}.pub
ssh-keygen -b 2048 -t rsa -f ./${base_name} -q -N ""

docker run --privileged -d -p ${port}:22 --name ${base_name} ${base_name} /sbin/init
sleep 3
ip=$(docker inspect -f "{{.NetworkSettings.IPAddress}}" ${base_name})

ssh-copy-id -i ./${base_name}.pub -f root@${ip}

echo "ssh -i ${base_name} root@${ip}" > ssh_${base_name}
chmod +x ssh_${base_name}
