#!/bin/bash
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#---------------------------------------------------------------
# Install docker
#---------------------------------------------------------------

sudo apt-get --fix-missing update
sudo apt-get install -y docker.io

#---------------------------------------------------------------
# Install containerd
#---------------------------------------------------------------
sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params (these persist across reboots)
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

# Install containerd
sudo apt-get --fix-missing update
sudo apt-get install -y containerd

# Create a containerd configuration file
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

#Set the cgroup driver for containerd to systemd which is required for the kubelet.
#For more information on this config file see:
# https://github.com/containerd/cri/blob/master/docs/config.md and also
# https://github.com/containerd/containerd/blob/master/docs/ops.md

#At the end of this section
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
        ...
#UPDATE: This line is now in the config.toml file
#change it from SystemdCgroup = false to SystemdCgroup = true
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
            SystemdCgroup = true

sudo vi /etc/containerd/config.toml


#Restart containerd with the new configuration
sudo systemctl restart containerd

#---------------------------------------------------------------
# Install kubelet
#---------------------------------------------------------------


#Install Kubernetes packages - kubeadm, kubelet and kubectl
#Add Google's apt repository gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


#Add the Kubernetes apt repository
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'


#Update the package list and use apt-cache policy to inspect versions available in the repository
sudo apt-get update
apt-cache policy kubelet | head -n 20 


#Install the required packages, if needed we can request a specific version. 
#Use this version because in a later course we will upgrade the cluster to a newer version.
VERSION=1.21.0-00
sudo apt-get install -y kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION
sudo apt-mark hold kubelet kubeadm kubectl containerd

#There is a breaking change in kubernetes 1.22, I will update the course shortly for that change for now use versions less than 1.22
#To install the latest, omit the version parameters
#sudo apt-get install kubelet kubeadm kubectl
#sudo apt-mark hold kubelet kubeadm kubectl containerd

#---------------------------------------------------------------
# Enable services
#---------------------------------------------------------------

#1 - systemd Units
#Check the status of our kubelet and our container runtime, containerd.
#The kubelet will enter a crashloop until a cluster is created or the node is joined to an existing cluster.
sudo systemctl status kubelet.service 
sudo systemctl status containerd.service 


#Ensure both are set to start when the system starts up.
sudo systemctl enable kubelet.service
sudo systemctl enable containerd.service

#---------------------------------------------------------------
# kubeadm init
#---------------------------------------------------------------

kubeadm config print init-defaults | tee ClusterConfiguration.yaml

sudo kubeadm init \
  --config=ClusterConfiguration.yaml \
  --cri-socket /run/containerd/containerd.sock

#---------------------------------------------------------------
# Create admin .kube config file
#---------------------------------------------------------------

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#---------------------------------------------------------------
# Install Calico
#---------------------------------------------------------------

wget https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f calico.yaml