# Vagrant part
 
Install Vagrant and Virtualbox on your local machine.

Now install Guest additions extension if you would like to have more functionalities inside your Virtualbox VM :

"vagrant plugin install vagrant-vbguest"

Then you just need to do **"vagrant up"** from the folder and it will automatically download CentOS 8 image, run it, update it, install Docker+Ansible and then it will build a Nginx Docker container with port 80 mapped to local port 80.

Please wait till the end of execution before doing anything on the VM.

After execution, it will restart the VM so the GUI can initialize.

Then you could do a curl or download Firefox to visit 127.0.0.1 and check that nginx is avalaible.

# Docker part

Download Vagrant, install it and then visit https://github.com/SmartGuyy/Projet3_Expert_DevOps_Vagrant to install a CentOS 8 VM that will automatically starts Docker container with nginx running on it.

Follow the README of the other repository and it should work as expected.

Otherwise you could just install docker locally and run the following steps : 

touch Dockerfile

echo "FROM debian:9 
EXPOSE 22/tcp
EXPOSE 80/tcp
RUN apt-get update -y \
&& apt-get install -y nginx" >> Dockerfile
## we build dockerfile
docker build -t nginx-projet . -f /home/vagrant/Dockerfile
## start container with port 80 mapped to local port 80 and restart it if it goes down
docker run -dit --restart unless-stopped --name nginx-projet -p 80:80 -d nginx  
## now check 127.0.0.1 in your browser !
 
