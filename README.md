# Machine image builder focused on Bitcoin

This tool is made of three technologies, Packer, Vagrant and Ansible, allowing us to generate an Ubuntu 18.10 VirtualBox 
image (and Vagrant box) packaged with softwares for Bitcoin / Lightning Network. You can find Bitcoin Core, LND, c-lightning, 
Electrum, a BitcoinJS guide, etc. <br/>
The image is ideal for Bitcoin workshops, hackathons, etc.


## What is inside

The VirtualBox image itself is not included in this repository, you need to generate it yourself with the `packer build` command, see below.
It usually takes between 30 minutes and 2 hours, depending on your internet connection and the speed of the Ubuntu mirror server.

### Operating System

Ubuntu 18.10 Cosmic - desktop version.
The [preseed.cfg](packer/http/ubuntu-desktop/preseed.cfg) file is used to do an automatic install.

### Softwares

- Bitcoin Core (latest) from the [Bitcoin PPA](https://launchpad.net/~bitcoin/+archive/ubuntu/bitcoin) 
  - Using the bitcoin.conf from the BitcoinJS guide
  - Set by default on Regtest mode

- Lightning Network  
  - LND
  - c-lightning  
  
- Wallets
  - Electrum  

- Terminal
  - ZSH (Antigen)
  - Tilix
    
- Code editors
  - Brackets
  - Vim

- Programming languages, compilers, ...
  - C
  - Node.js (v10)
  - Go (v1.11.5)  

- Various libraries
  - Libbitcoin-explorer (bx)
  - JQ


You can deactivate installation of what you don't want by removing roles in the main [playbook](ansible/playbook.yml).


### BitcoinJS guide

Included right on the desktop is the extensive [BitcoinJS guide](https://github.com/bitcoin-studio/Bitcoin-Programming-with-BitcoinJS)
made by Stéphane Roche from Bitcoin-Studio. You can explore it to learn how to do all kinds of Bitcoin transaction.


## How to import and launch the VM

There are two ways to launch the VM, from VirtualBox or from Vagrant.

### Using VirtualBox

After a build you will find two files in the `packer/outputs` directory, a .ovf and a .vmdk.  
To import the image into VirtualBox you can double-click on the `.ovf` file or select it from the VirtualBox import panel.

You have to uncheck "Import hard drives as VDI", otherwise you get a `NS_ERROR_INVALID_ARG (0x80070057)` error.

After importation you can select it and click start.

### Using Vagrant

With Vagrant, you have to add the Vagrant box to Vagrant and run it. See the Vagrant section below.


## How to login

There is only one user, username: `bitcoin`, password: `bitcoin`. 
It has sudo access without password!
There is no `root` user.
When you launch the VM it has auto-login feature activated.

If you want to connect in command-line from the host machine, you can do it with `vagrant ssh`, see below.


## How to generate a VM image 

We use Packer to create the VirtualBox virtual image and a vagrant box.
Ansible is used to provision the virtual image.

### Packer

Generate the virtualbox image and the vagrant box
```
$ cd packer
$ NAME=ubuntu-18.10-desktop-amd64 UBUNTU_CODENAME=cosmic packer build -force ubuntu-desktop.json 
```

And with more logs 
```
$ PACKER_LOG=1 NAME=ubuntu-18.10-desktop-amd64 UBUNTU_CODENAME=cosmic packer build -force -on-error=ask ubuntu-desktop.json
```

#### Setting a Ubuntu mirror server

If the OS installation is too slow you can set an other Ubuntu mirror in the 
[preseed.cfg](packer/http/ubuntu-desktop/preseed.cfg) file, choosing one close to your location.
> Line: d-i mirror/http/hostname string MIRROR

### Vagrant

Add the box to Vagrant
```
$ vagrant box add --name ubuntu1810-bitcoin packer/outputs/ubuntu-18.10-desktop-amd64-virtualbox.box
```

Launch the VM
> We need to cd into `./vagrant` because the ssh keys are there, and to have everything Vagrant related in this directory
```
$ cd vagrant
$ vagrant init ubuntu1810-bitcoin
$ vagrant up
```

Run the Ansible provisioning against the vagrant box
```
$ vagrant provision ubuntu1810-bitcoin
```

Print the Vagrantfile included in the box
```
$ tar -O -xf packer/outputs/ubuntu-18.10-desktop-amd64-virtualbox.box Vagrantfile
```

#### SSH connection to VM via vagrant

Generate a new ssh key pair
> I place them into `./vagrant` directory, named `vagrant-rsa` and `vagrant-rsa.pub`
```
$ cd vagrant
$ ssh-keygen
> Enter file in which to save the key (/Users/steph/.ssh/id_rsa): vagrant-rsa
```

The script [vagrant.sh](packer/scripts/linux-common/vagrant.sh) is used by Ansible to copy the ssh public key to the VM. 
The key is hardcoded there, change it if needed.

If you want to copy the ssh public key to the VM manually
```
$ cd vagrant
$ cat vagrant-rsa.pub | ssh bitcoin@127.0.0.1 -p 2222 "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

Establish a SSH connection
> If the SSH keys are ok you should not be asked for a password
```
$ vagrant ssh
```

#### Shared folder

Vagrant allows you to have a shared folder between your host machine (at `vagrant/shared`) and the guest VM 
(at `/home/bitcoin/Desktop`).

You need to install vagrant-vbguest
```
$ vagrant plugin install vagrant-vbguest
```

### Ansible

Create a new role with all the boilerplate
```
$ ansible-galaxy init ROLE
```

Check playbooks syntax
> It is useful to execute it before running a packer build
```
$ cd ansible
$ ansible-playbook playbook.yml --syntax-check
```


## Troubleshooting

#### The font is too small
You can increase the scale factor in Virtual Box and/or in Gnome-Tweak-Tool present on the desktop.

#### The display is buggy after a resize
Changing the "resize" and "scale" from `View > Virtual Screen 1` VirtualBox menu should fix it.


## Open Source 

You like this repo? Feel free to like and share. <br/>
You see room for improvement? Feel free to contribute. <br/>
You want to buy me a beer? [3CmJsUcx6txveq32kVqG92pczc1suLh6BD](bitcoin_donation.png) <br/>