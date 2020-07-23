#!/bin/bash

# install latest version of docker the lazy way
curl -sSL https://get.docker.com | sh

# make it so you don't need to sudo to run docker commands
usermod -aG docker ubuntu

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# download source code from github and store it in /srv/docker
mkdir /srv/docker
curl -o /srv/docker/release.zip -LJO https://github.com/TopSwagCode/lightsail.aspnetcore/archive/master.zip
cd /srv/docker

# install Zip and unzip and move files into current folder
apt-get update
apt-get install zip unzip -qy
unzip release.zip
mv lightsail.aspnetcore-master/* .

# move linux service file to /etc/systemd/system/ and enable the service
mv docker-compose-app.service /etc/systemd/system/
systemctl enable docker-compose-app

# start up the application via docker-compose.
docker-compose -f docker-compose.yml up -d --build