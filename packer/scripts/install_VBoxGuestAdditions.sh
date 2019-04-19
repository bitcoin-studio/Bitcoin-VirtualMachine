#!/usr/bin/env bash

#sudo mount /home/bitcoin/VBoxGuestAdditions.iso /mnt
#cd /mnt
#sudo ./VBoxLinuxAdditions.run

# Make errors happen in a subprocess and not catched in the current process.
# The last operation's result will be the result of the script.
# If the last check errored, something went wrong in the installation.
# https://stackoverflow.com/questions/25434139/vboxlinuxadditions-run-never-exits-with-0/52995861#52995861

sudo mount /home/bitcoin/VBoxGuestAdditions.iso /mnt
echo "sudo /mnt/VBoxLinuxAdditions.run" > /tmp/install_va.sh
/bin/bash /tmp/install_va.sh
sudo /usr/sbin/VBoxService --version