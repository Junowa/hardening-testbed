#!/bin/bash -eux


echo "### Install provisioner ssh public key"
mkdir -p /home/provisioner/.ssh
chmod 0700 /home/provisioner/.ssh
mv /tmp/provisioner.pub /home/provisioner/.ssh/authorized_keys
chmod 0600 /home/provisioner/.ssh/authorized_keys
chown -R provisioner: /home/provisioner/.ssh

echo "### Update system"
yum -y update

echo "### Install additional packages"
yum -y install perl
sleep 5
yum -y install epel-release
sleep 5
yum -y install ntfs-3g
sleep 5
yum -y install vim
sleep 5
yum -y install rsync

echo "### Clean yum metadata"
yum -y clean all


rm /etc/ssh/ssh_host_*


