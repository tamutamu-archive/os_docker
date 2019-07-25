#!/bin/bash

name=$(basename $(pwd))
port=2222

rm -f ${name} ${name}.pub
ssh-keygen -b 2048 -t rsa -f ./${name} -q -N ""

docker run -d --name ${name} --security-opt seccomp=unconfined --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t os_ubuntu18_base
sleep 3

docker cp ./${name}.pub ${name}:/tmp/
docker exec -it ${name} sh -c "cat /tmp/${name}.pub >> /root/.ssh/authorized_keys"


ip=$(docker inspect -f "{{.NetworkSettings.IPAddress}}" ${name})

echo "ssh -i ${name} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@${ip}" > ssh_${name}
chmod +x ssh_${name}
