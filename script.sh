#!/bin/bash

dnf update -y 

# removing previous install of docker
rm -rf /var/lib/docker
dnf remove docker docker-ce docker-ce-cli containerd.io

# installing GUI tools
dnf groupinstall -y gnome-desktop
dnf install -y xorg*

# removing useless tools
dnf remove -y initial-setup initial-setup-gui

# set persistent GUI
systemctl isolate graphical.target
systemctl set-default graphical.target

# to add docker repository
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

# to add latest docker-ce version
dnf install docker-ce --nobest -y

# installing tools
dnf install -y device-mapper-persistent-data lvm2 nano

# enabling and starting docker
systemctl start docker
systemctl enable docker

# installing ansible
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf install -y ansible

# set keyboard to french
localectl set-keymap fr

# create Dockerfile and execute it so container is ready on startup
cd /home/vagrant
touch Dockerfile
echo "FROM debian:9 
EXPOSE 22/tcp
EXPOSE 80/tcp
RUN apt-get update -y \
&& apt-get install -y nginx" >> Dockerfile
# we build dockerfile
docker build -t nginx-projet .
# start container with port 80 mapped to local port 80
docker run --name nginx-projet -p 80:80 -d nginx 
