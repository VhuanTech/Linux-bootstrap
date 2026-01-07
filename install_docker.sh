#!/bin/sh
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release
# Add mirror
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update
# To support Schema 1 images
sudo apt install -y docker-ce=5:26.1.4-1~ubuntu.20.04~focal docker-ce-cli=5:26.1.4-1~ubuntu.20.04~focal containerd.io docker-compose-plugin

# install nvidia container toolkit
distribution=$(
  . /etc/os-release
  echo $ID$VERSION_ID
)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# configure docker mirror and cache
sudo cp ./docker/daemon.json /etc/docker/

sudo systemctl restart docker

cat <<EOF >>~/.bashrc
alias dcb='sudo docker compose build'
alias dcu='sudo docker compose up -d'
alias dcd='sudo docker compose down'
alias dcp='sudo docker compose ps'
alias dcl='sudo docker compose logs >/tmp/logs && vim /tmp/logs'
alias dcr='sudo docker compose down && sudo docker compose build && sudo docker compose up -d'
alias dcrt='sudo docker compose -f docker-compose.test.yml down && sudo docker compose -f docker-compose.test.yml build && sudo docker compose -f docker-compose.test.yml up -d'
alias dcdt='sudo docker compose -f docker-compose.test.yml down'
alias dcp='sudo docker compose ps'
EOF
