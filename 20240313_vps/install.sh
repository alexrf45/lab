#! /bin/bash

sudo -u fr3d -i <<'EOF

sudo apt-get update && sudo apt-get install -y tmux zsh jq wget curl lolcat figlet unzip

curl -fsSL https://get.docker.com -o get-docker.sh

sh get-docker.sh

sudo usermod -aG docker $USER

rm get-docker.sh

sudo docker pull fonalex45/aegis:latest

curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip &&
	unzip awscliv2.zip && sudo ./aws/install && rm -r aws/ && rm awscliv2.zip

mkdir -p $HOME/.zsh

mkdir -p $HOME/.tmux

mkdir -p $HOME/.config

wget -q https://raw.githubusercontent.com/alexrf45/aegis/main/resources/zsh/tmux.conf -O .tmux.conf

wget -q "https://raw.githubusercontent.com/alexrf45/aegis/main/bash/aegis" -O .zsh/aegis

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "source $HOME/.zsh/aegis" >> /home/fr3d/.zshrc

chmod +x /home/fr3d/.zsh/aegis

echo "alias t="tmux new -f ~/.tmux.conf -s $1"" >> /home/fr3d/.zshrc

echo "alias c="clear"" >> /home/fr3d/.zshrc

sudo chsh fr3d -s /usr/bin/zsh

EOF
