#!/bin/bash

sudo yum install -y wget

# Create ansible user account
sudo adduser antsy -d /home/antsy

# Add ssh key
sudo mkdir -p /home/antsy/.ssh
sudo wget http://gogsdirect.t-vo.us:10080/taylor/ssh_keys/raw/master/antsy_id_rsa.pub -O /home/antsy/.ssh/authorized_keys
sudo chmod 0600 /home/antsy/.ssh/authorized_keys
sudo chown -R antsy:antsy /home/antsy/.ssh

# Add to sudoers
sudo bash -c 'echo "antsy ALL=NOPASSWD:ALL" > /etc/sudoers.d/antsy'
