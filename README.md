# Machine image builder focused on Bitcoin

**Quick Start**: _Install Vagrant and Virtualbox. 
Then open a CLI terminal, and run `vagrant init bitcoin-studio/Bitcoin-VirtualMachine; vagrant up;`. 
Or download the [VirtualBox image](https://keybase.pub/janakasteph/Bitcoin-VirtualMachine) and double-click the .ovf file. 
You're now in an environment with lnd and other Bitcoin tools. If that doesn't work, read further on in this guide for more details._

## Summary

This tool is made of three technologies, Packer, Vagrant and Ansible, allowing us to generate an Ubuntu 18.10 VirtualBox 
image and a Vagrant box packaged with softwares for Bitcoin / Lightning Network. You can find Bitcoin Core, LND, c-lightning, 
Electrum, a BitcoinJS guide, etc. <br/>
The image is ideal for Bitcoin workshops, hackathons, etc. <br/>
The VirtualBox image itself is not included in this repository. 


### Operating System

Ubuntu 18.10 Cosmic - desktop version.
The [preseed.cfg](packer/http/preseed.cfg) file is used to do an automatic install.

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


### VirtualBox Guest Additions

VirtualBox Guest Additions has been installed to give you the ability to copy/paste and drag/drop between your host 
machine and the VM.


## How to import and launch the VM

There are two ways to launch the VM, from VirtualBox or from Vagrant.

### Using VirtualBox

After a build you will find two files in the `packer/outputs` directory, a .ovf and a .vmdk.  
To import the image into VirtualBox you can double-click on the `.ovf` file or select it from the VirtualBox import panel.

If you get a `NS_ERROR_INVALID_ARG (0x80070057)` error, try to uncheck "Import hard drives as VDI".  


### Using Vagrant

Launch the VM
```
$ vagrant init bitcoin-studio/Bitcoin-VirtualMachine
$ vagrant up
```

`vagrant init` will import the box hosted on [Vagrant Cloud](https://app.vagrantup.com/bitcoin-studio/boxes/Bitcoin-VirtualMachine).


## How to login

There is only one user, username: `bitcoin`, password: `bitcoin`. 
It has sudo access without password!
There is no `root` user.
When you launch the VM it has auto-login feature activated.

If you want to connect in command-line from the host machine, you can do it with `vagrant ssh`, see below.

### SSH connection to VM via vagrant

Vagrant will use "insecure" SSH keypair provided by Hashicorp.

Establish a SSH connection
> If the SSH keys are ok you should not be asked for a password, otherwise password is "bitcoin"
```
$ vagrant ssh
```


## How to generate a VM image 

We use Packer to create the VirtualBox virtual image and a vagrant box.
Ansible is used to provision the virtual image.
It usually takes between 30 minutes and 2 hours, depending on your internet connection and the speed of the Ubuntu mirror server.

### Packer
> You will need to remove the `vagrant-cloud` post-processor from [packer/template.json](packer/template.json)
> to avoid Vagrant Cloud authentication error. 

Generate the virtualbox image and the vagrant box
```
$ cd packer
$ PACKER_LOG=1 PACKER_LOG_PATH=packer.log packer build -force -on-error=ask template.json
```

Keep an eye on the log
```
$ tail -f packer.log
```

#### Setting a Ubuntu mirror server

If the OS installation is too slow you can set an other Ubuntu mirror in the 
[preseed.cfg](packer/http/preseed.cfg) file, choosing one close to your location.
> Line: d-i mirror/http/hostname string MIRROR


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