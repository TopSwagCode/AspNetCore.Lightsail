#!/bin/bash
# Download Startup install service script
curl -o ./lightsail.sh https://github.com/TopSwagCode/lightsail.aspnetcore/blob/master/install-docker.sh

# Make it runable
chmod +x ./lightsail.sh 

# Run it
./lightsail.sh