#!/bin/bash

sudo apt update && sudo apt install vim git tmux wget curl fail2ban

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sudo usermod -aG docker sean

wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

tar xzvf nvim-linux-x86_64.tar.gz

cp nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

chmod +x /usr/local/bin/nvim

mkdir .config

git clone https://github.com/LazyVim/starter ~/.config/nvim

rm -rf ~/.config/nvim/.git

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
