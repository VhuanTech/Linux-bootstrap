#!/bin/bash
curl -L https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz | gunzip -c > ./tree-sitter
chmod +x ./tree-sitter
sudo mv ./tree-sitter /usr/local/bin/
