FROM debian:9
EXPOSE 22/tcp
EXPOSE 80/tcp
RUN apt-get update -y \
&& apt-get install -y nginx