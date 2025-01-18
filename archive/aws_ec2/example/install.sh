#!/bin/bash

apt update && apt install vim git curl wget tmux

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

usermod -aG docker test
