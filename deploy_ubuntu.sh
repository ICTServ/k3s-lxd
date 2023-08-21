#!/bin/bash
set -e

container_name=$1
if [ -z $container_name ]; then
    container_name=k3s-master
    echo "Using default name: ${container_name}"
fi

# Profile created in setup.sh
profile=k3s

lxc init images:ubuntu/mantic/amd64 --profile $profile $container_name
lxc config device add "${container_name}" "kmsg" unix-char source="/dev/kmsg" path="/dev/kmsg"

cat > install_ubuntu.sh << EOF
apt update && apt -y install curl openssh-server && systemctl enable --now ssh
sleep 30
EOF
lxc start $container_name
sleep 5

lxc file push install_k3s.sh $container_name/tmp/install_ubuntu.sh
lxc exec $container_name -- bash /tmp/install_ubuntu.sh

rm -rf install_k3s.sh
k3sip=$(lxc list $container_name | grep eth0| head -1 | awk '{print $4}')
echo "$container_name installed"
