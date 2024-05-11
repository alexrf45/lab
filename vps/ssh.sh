#!/bin/bash

echo "$(terraform output -raw vps_public_ip)"

terraform output -raw ssh_key >$HOME/.ssh/vps

chmod 600 $HOME/.ssh/vps
