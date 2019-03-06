#!/bin/bash -eux

date > /etc/vagrant_box_build_time

SSH_USER=${SSH_USERNAME:-bitcoin}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}
VAGRANT_RSA="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDU7VvAucz/l4QcDwrdfGbmfRLszxotjZj09kKJh8Qts5fVB+HA3xdFUyiGAgS2A8kCmyoyrg4N3Z7kcKfbKdunxb9zw3BlSO5KhRc1y7ZN1euwrMOPRnNjSEQHuaq2Hy89UfvuD+bt0O6BcZtOvUViY9+lctwAw+aoxhBT8KWCV/NrK6vHtYFsLPHXCKv2EmETuI749k2nWFDxDvFJ04KZkH6p7/pEu+emmapRb/56Vy2xi+dCJ9ASyZj6qo4SLJgvk9iF51Pfupn+XvgviDqoBaMSikWlXLYYFq2GCA75VorFYtm/vL1qFUfv4+tGnBoN/q7hZjOBd/byfZqW9Vah steph@FancyNewName"

# Set up sudo
#echo "==> Giving ${SSH_USER} sudo powers"
#echo "${SSH_USER}        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/vagrant

echo "==> Installing vagrant key"
if [ ! -d $SSH_USER_HOME/.ssh ]; then
  mkdir $SSH_USER_HOME/.ssh
fi
chmod 700 $SSH_USER_HOME/.ssh

echo "${VAGRANT_RSA}" > $SSH_USER_HOME/.ssh/authorized_keys
chmod 600 $SSH_USER_HOME/.ssh/authorized_keys
chown -R $SSH_USER:$SSH_USER $SSH_USER_HOME/.ssh
