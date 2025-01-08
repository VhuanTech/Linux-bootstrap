#!/bin/sh
read -p "Create swap? (y/n) " swap
if [ "$swap" = "y" ]; then
    read -p "swap size in GB: " swap_size
    sudo fallocate -l ${swap_size}G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo cat <<EOF1 >/etc/fstab
/swapfile none swap sw 0 0
EOF1
fi

read -p "Configure ssh client alive interval? (y/n) " ssh_config
if [ "$ssh_config" = "y" ]; then
    mkdir -p ~/.ssh
    cat <<EOF2 > ~/.ssh/config
Host * ServerAliveInterval 60
EOF2
fi
