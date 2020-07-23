#!/bin/bash

# install latest version of docker the lazy way
curl -sSL https://get.docker.com | sh

# make it so you don't need to sudo to run docker commands
usermod -aG docker ubuntu

# make it so you don't need to sudo to run docker commands
usermod -aG docker ubuntu

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# copy the dockerfile into /srv/docker 
mkdir /srv/docker
curl -o /srv/docker/release.zip -LJO https://github.com/TopSwagCode/lightsail.aspnetcore/archive/master.zip
cd /srv/docker
# Unzip and move files into current folder
apt-get update
apt-get install zip unzip -qy
unzip release.zip
mv lightsail.aspnetcore-master/* .

## !!!!! TODO !!!!! Move docker-compose-app.service file to  /etc/systemd/system/ folder!
#curl -o /etc/systemd/system/docker-compose-app.service https://raw.githubusercontent.com/mikegcoleman/todo/master/docker-compose-app.service
#systemctl enable docker-compose-app

# start up the application via docker-compose. !!!! TODO !!!!! Use build. To ensure we always get latests version!.
docker-compose -f docker-compose.yml up -d