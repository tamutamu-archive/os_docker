#!/bin/bash

base_name=os_ubuntu18
port=2222

rm -f ${base_name} ${base_name}.pub
ssh-keygen -b 2048 -t rsa -f ./${base_name} -q -N ""

docker run --privileged -d -p ${port}:22 -p 8888:8888 --name ${base_name} ${base_name} /sbin/init
sleep 3

docker cp ./${base_name}.pub ${base_name}:/tmp/
docker exec -it ${base_name} sh -c "cat /tmp/${base_name}.pub >> /root/.ssh/authorized_keys"


ip=$(docker inspect -f "{{.NetworkSettings.IPAddress}}" ${base_name})

echo "ssh -i ${base_name} root@${ip}" > ssh_${base_name}
chmod +x ssh_${base_name}
