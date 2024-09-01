#!/bin/bash

sudo apt update && sudo apt install vim git tmux wget curl fail2ban

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sudo usermod -aG docker sean
