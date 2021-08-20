#! /bin/bash
sudo apt -y update
sudo apt upgrade -y
sudo apt install -y curl git unzip htop neofetch

wget https://github.com/tkuchiki/alp/releases/download/v1.0.7/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo mv alp /usr/local/bin

wget https://github.com/percona/percona-toolkit/archive/3.0.5-test.tar.gz
tar zxvf 3.0.5-test.tar.gz
sudo mv $HOME/percona-toolkit-3.0.5-test/bin/pt-query-digest /usr/local/bin

if [ -e $HOME/.ssh/id_rsa ]; then
  sudo mv $HOME/.ssh/id_rsa $HOME/.ssh/id_rsa.bak
fi

ssh-keygen -t rsa -N "" -f .ssh/id_rsa

