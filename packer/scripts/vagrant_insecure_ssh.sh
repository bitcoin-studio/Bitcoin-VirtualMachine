#!/usr/bin/env bash

# Insecure ssh key Hashicorp offers to base box creators for use in their base boxes so that vagrant
# installations can automatically SSH into the boxes.
# https://github.com/hashicorp/vagrant/tree/master/keys

SSH_USER='bitcoin'
SSH_USER_HOME="/home/${SSH_USER}"

echo "==> Installing insecure SSH vagrant key"

if [ ! -d $SSH_USER_HOME/.ssh ]; then
  mkdir $SSH_USER_HOME/.ssh
fi

wget --no-check-certificate https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -O .ssh/authorized_keys
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
chown -R ${SSH_USER}:${SSH_USER} .ssh