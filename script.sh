#!/bin/bash
# WARNING : wait till script finished running

dnf update -y 

# removing previous install of docker
rm -rf /var/lib/docker
dnf remove docker docker-ce docker-ce-cli containerd.io

# installing GUI tools
dnf groupinstall -y gnome-desktop
dnf install -y xorg*

# removing useless GUI tools
dnf remove -y initial-setup initial-setup-gui

# set persistent GUI
systemctl isolate graphical.target
systemctl set-default graphical.target

# to add docker repository
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

# to add latest docker-ce version
dnf install docker-ce --nobest -y

# installing tools
dnf install -y device-mapper-persistent-data lvm2

# adding repo and installing vsscode
rpm --import https://packages.microsoft.com/keys/microsoft.asc

tee /etc/yum.repos.d/vscode.repo <<ADDREPO
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
ADDREPO

dnf install code -y

# enabling and starting docker
systemctl start docker
systemctl enable docker

# installing ansible
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf install -y ansible

# set keyboard to french
localectl set-keymap fr

# install firefox
dnf install firefox -y

# create Dockerfile and execute it so container is ready on startup
touch /home/vagrant/Dockerfile
echo "FROM debian:9 
EXPOSE 22/tcp
EXPOSE 80/tcp
RUN apt-get update -y \\
&& apt-get install -y nginx" >> /home/vagrant/Dockerfile
# we build dockerfile
docker build -t nginx-projet . -f /home/vagrant/Dockerfile
# start container with port 80 mapped to local port 80 and restart it if it goes down
docker run -d --restart unless-stopped --name nginx-projet -p 80:80 nginx 

reboot now
