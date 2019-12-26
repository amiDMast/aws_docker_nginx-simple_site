#!/bin/bash
sudo echo "Start install $(date)" >> /log.txt
sudo yum install docker -y
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo docker-compose --version

sudo cat > /etc/docker/daemon.json <<EOF
{
  "storage-driver": "devicemapper"
}
EOF


sudo service docker start
sudo chkconfig docker on
sudo echo "$(docker info)" >> /log.txt
sudo yum install git -y

sudo mkdir /DOCKER/
sudo cd /DOCKER/
sudo git clone https://github.com/amiDMast/docker-nginx.git
sudo mv ./docker-nginx/* .
sudo rm -rf ./docker-nginx
sudo docker-compose build
sudo docker-compose up -d
sudo echo "Finish install $(date)" >> /log.txt
