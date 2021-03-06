#!/bin/bash -eux

echo "### Install VBox requirements"
yum -y install perl gcc make kernel-devel bzip2 

mkdir -p /media/cdrom
mount VBoxGuestAdditions_*.iso /media/cdrom

/media/cdrom/VBoxLinuxAdditions.run

echo "### Add vagrant user (provisioner) and password-less sudo"
sed -i -e "s/^provisioner.*$/provisioner     ALL=(ALL)        NOPASSWD:ALL/" /etc/sudoers


echo "### Clean VBox install stuff"
umount /media/cdrom
rm -rf /media/cdrom

yum -y remove gcc make kernel-devel 

yum -y clean all
rm -rf /var/tmp/yum-*


