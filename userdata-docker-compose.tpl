#!/bin/bash
sudo apt-get update -y &&
curl -fsSL https://get.docker.com -o get-docker.sh &&
sudo sh get-docker.sh &&
sudo usermod -aG docker ubuntu &&
mkdir -p ~/.docker/cli-plugins/ &&
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose &&
chmod +x ~/.docker/cli-plugins/docker-compose