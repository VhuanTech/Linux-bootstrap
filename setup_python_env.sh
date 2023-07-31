#!/bin/sh
mkdir -p ~/.pip/
cat <<EOF1 > ~/.pip/pip.conf
[global]
index-url=https://mirrors.cloud.tencent.com/pypi/simple

[install]
trusted-host=mirrors.cloud.tencent.com
EOF1

sudo apt install -y pylint
pylint --generate-rcfile > ~/.pylintrc
cat <<EOF >> ~/.pylintrc
extension-pkg-allow-list=cv2
generated-members=cv2
EOF
