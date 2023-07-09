#!/bin/sh
mkdir -p ~/.pip/
cat <<EOF > ~/.pip/pip.conf
[global]
index-url=https://mirrors.cloud.tencent.com/pypi/simple

[install]
trusted-host=mirrors.cloud.tencent.com
EOF

