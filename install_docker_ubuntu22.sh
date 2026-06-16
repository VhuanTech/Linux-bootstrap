#!/bin/sh
set -e

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

if [ "$1" != "--no-nvidia" ]; then
  curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/nvidia-docker.gpg
  distribution=$(
    . /etc/os-release
    echo $ID$VERSION_ID
  )
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/nvidia-docker.gpg] https://nvidia.github.io/nvidia-docker/$distribution/$(dpkg --print-architecture) /" | sudo tee /etc/apt/sources.list.d/nvidia-docker.list >/dev/null
  sudo apt-get update
  sudo apt-get install -y nvidia-container-toolkit
fi

sudo cp ./docker/daemon.json /etc/docker/
sudo systemctl restart docker

cat <<'EOF' >>~/.bashrc
alias dcb='sudo docker compose build'
alias dcu='sudo docker compose up -d'
alias dcd='sudo docker compose down'
alias dcp='sudo docker compose ps'
alias dcl='sudo docker compose logs >/tmp/logs && vim /tmp/logs'
alias dcr='sudo docker compose down && sudo docker compose build && sudo docker compose up -d'
alias dcrt='sudo docker compose -f docker-compose.test.yml down && sudo docker compose -f docker-compose.test.yml build && sudo docker compose -f docker-compose.test.yml up -d'
alias dcdt='sudo docker compose -f docker-compose.test.yml down'
EOF

echo "Docker installation complete."
docker --version || echo "Please log out and back in or run 'newgrp docker' to use Docker without sudo."
