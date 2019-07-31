#!/bin/bash

name=$(basename $(pwd))
port=2222

rm -f ${name} ${name}.pub
ssh-keygen -b 2048 -t rsa -f ./${name} -q -N ""

docker run --privileged -d -p ${port}:22 \
  --mount type=bind,source="$(pwd)"/mount,target=/mnt/mount \
  --name ${name} ${name} /sbin/init
sleep 3

docker cp ./${name}.pub ${name}:/tmp/
docker exec -it ${name} sh -c "cat /tmp/${name}.pub >> /root/.ssh/authorized_keys"


ip=$(docker inspect -f "{{.NetworkSettings.IPAddress}}" ${name})

echo "ssh -i ${name} root@${ip}" > ssh_${name}
chmod +x ssh_${name}
