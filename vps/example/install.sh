#!/bin/bash

sudo apt update && sudo apt install vim git tmux wget curl

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

usermod -aG docker fr3d
