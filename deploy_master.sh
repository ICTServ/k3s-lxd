#!/bin/bash
set -e

container_name=$1
if [ -z $container_name ]; then
    container_name=k3s-master
    echo "Using default name: ${container_name}"
fi

# Profile created in setup.sh
profile=k3s

lxc init images:ubuntu/jammy/amd64 --profile $profile $container_name
lxc config device add "${container_name}" "kmsg" unix-char source="/dev/kmsg" path="/dev/kmsg"

cat > install_k3s.sh << EOF
apt update && apt install curl openssh-server -y && systemctl enable --now ssh
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.24.16 K3S_URL=https://$K3S_MASTER_IP:6443 K3S_TOKEN=SECRET  sh -
sleep 30
EOF

lxc start $container_name
sleep 5

lxc file push install_k3s.sh $container_name/tmp/install_k3s.sh
lxc exec $container_name -- bash /tmp/install_k3s.sh

rm -rf install_k3s.sh
k3sip=$(lxc list $container_name | grep eth0| head -1 | awk '{print $4}')
echo "writing config to $(pwd)/kubeconfig"
lxc exec $container_name -- bash -c "sed 's/127.0.0.1/$k3sip/g' /etc/rancher/k3s/k3s.yaml" > $(pwd)/kubeconfig
