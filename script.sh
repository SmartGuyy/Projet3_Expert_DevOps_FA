#!/bin/bash
 
yum update -y 
yum install -y  yum-utils device-mapper-persistent-data lvm2
yum install -y  docker
yum install -y  epel-repo
yum install -y  ansible
yum install -y nano