#!/bin/bash

curl -LOk https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
	export PATH="$PATH:/opt/nvim-linux-x86_64/bin" && \
	mv ~/.config/nvim{,.bak} && \
	git clone https://github.com/LazyVim/starter ~/.config/nvim
