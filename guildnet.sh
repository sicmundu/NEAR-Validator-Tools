#!/bin/bash
sudo apt update && sudo apt upgrade -y
curl -sL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt install build-essential nodejs -y
PATH="$PATH"
sudo npm install -g near-cli -y
apt install python3-pip -y 
pip3 install --user nearup
USER_BASE_BIN=$(python3 -m site --user-base)/bin
