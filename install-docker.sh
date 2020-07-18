#!/bin/bash

# Setup Repository
sudo apt-get update
echo '* libraries/restart-without-asking boolean true' | sudo debconf-set-selections
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
#sudo apt-get update && sudo apt-get install docker.io
#sudo systemctl start docker
#sudo systemctl enable docker

# make it so you don't need to sudo to run docker commands
sudo usermod -aG docker ubuntu

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# copy the dockerfile into /srv/docker 
# if you change this, change the systemd service file to match
# WorkingDirectory=[whatever you have below]
mkdir /srv/docker
curl -o /srv/docker/release.zip -LJO https://github.com/TopSwagCode/lightsail.aspnetcore/archive/master.zip
cd /srv/docker
# Unzip and move files into current folder
sudo apt-get update
sudo apt-get install zip unzip -qy
sudo unzip release.zip
sudo mv lightsail.aspnetcore-master/* .

## !!!!! TODO !!!!! Move docker-compose-app.service file to  /etc/systemd/system/ folder!
#curl -o /etc/systemd/system/docker-compose-app.service https://raw.githubusercontent.com/mikegcoleman/todo/master/docker-compose-app.service
#systemctl enable docker-compose-app

# start up the application via docker-compose. !!!! TODO !!!!! Use build. To ensure we always get latests version!.
sudo docker-compose -f docker-compose.yml up -d