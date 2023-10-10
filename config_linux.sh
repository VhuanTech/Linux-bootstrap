#!/bin/sh
read -p "Create swap? (y/n) " swap
if [ "$swap" = "y" ]; then
    read -p "swap size in GB: " swap_size
    sudo fallocate -l ${swap_size}G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
fi

read -p "Configure ssh client alive interval? (y/n) " ssh_config
if [ "$ssh_config" = "y" ]; then
    mkdir -p ~/.ssh
    cat <<EOF > ~/.ssh/config
Host * ServerAliveInterval 60
EOF
fi
