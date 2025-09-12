#!/bin/sh
sudo apt update
sudo apt install -y python3.9 python3.9-dev

mkdir -p ~/.pip/
cat <<EOF1 > ~/.pip/pip.conf
[global]
index-url=https://mirrors.cloud.tencent.com/pypi/simple
cache-dir=/data/cache/pip/

[install]
trusted-host=mirrors.cloud.tencent.com
EOF1

pip install -U pip

sudo apt install -y pylint
pylint --generate-rcfile > ~/.pylintrc
cat <<EOF >> ~/.pylintrc
extension-pkg-allow-list=cv2
generated-members=cv2
EOF
