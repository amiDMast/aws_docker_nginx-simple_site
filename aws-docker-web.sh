#!/bin/bash
echo "Start install $(date)" >> /log.txt
yum update -y
yum install docker git -y
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
service docker start
chkconfig docker on
mkdir /DOCKER/
cd /DOCKER/
git clone https://github.com/amiDMast/docker-nginx.git
mv ./docker-nginx/* /DOCKER/
rm -rf ./docker-nginx
docker-compose build
docker-compose up -d
echo "Finish install $(date)" >> /log.txt
