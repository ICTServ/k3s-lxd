# k3s-on-lxd

K3S on LXD 

## Pre-Requirements

[LXD](https://linuxcontainers.org/lxd/getting-started-cli/) is required

## Usage

Get the sources:

```
git clone https://github.com/ICTServ/k3s-lxd.git && cd k3s-lxd && chmod +x *.sh
```
```
./setup.sh
```
```
./deploy_master.sh k3s-master-1
```
```
cd && export KUBECONFIG=/home/user/kubeconfig
```
```
./deploy_agent.sh k3s-node-1
```
```
./deploy_agent.sh k3s-node-2
```
```
./deploy_agent.sh k3s-node-3
```

```
Create the lxc profile:

```
$ ./setup.sh
```

```
```
curl -sLS https://raw.githubusercontent.com/ICTServ/k3s-lxd/main/setup.sh | sh
```
```
curl -sLS https://raw.githubusercontent.com/ICTServ/k3s-lxd/main/deploy_master.sh | sh
```
```
curl -sLS https://raw.githubusercontent.com/ICTServ/k3s-lxd/main/deploy_agent.sh | sh
```
```

Deploy a master:

```
$ ./deploy_master.sh k3s-master
...
[INFO]  systemd: Starting k3s
writing config to /home/user/kubeconfig
```

Deploy 2 agents:

```
```
 ./deploy_agent.sh k3s-node-1
 ```
```
 ./deploy_agent.sh k3s-node-2
```
```

View the nodes using kubectl:

```
```
export KUBECONFIG=/home/user/kubeconfig
```
```
kubectl get nodes
```
```
NAME         STATUS   ROLES    AGE     VERSION
k3s-master   Ready    master   5m17s   v1.17.4+k3s1
k3s-node-1   Ready    <none>   3m29s   v1.17.4+k3s1
k3s-node-2   Ready    <none>   2m33s   v1.17.4+k3s1
```

If you have docker installed but not kubectl:

```
$ docker run -it -v $PWD/kubeconfig:/root/.kube/config ruanbekker/kubectl kubectl get nodes
NAME         STATUS   ROLES    AGE     VERSION
k3s-master   Ready    master   5m17s   v1.17.4+k3s1
k3s-node-1   Ready    <none>   3m29s   v1.17.4+k3s1
k3s-node-2   Ready    <none>   2m33s   v1.17.4+k3s1
```
