install
cdrom
text
skipx

# Keyboard/Language
lang fr_FR
keyboard 'fr'

network --onboot=yes --device eth0 --bootproto=dhcp --hostname=centos7-template

# Default root passwd: Azerty5*
rootpw --iscrypted $6$16_qkqlsdjhfuiaz$10SpiiJ3LuAYBPCsq2ays.NO2azbmL.x1cIHjBGO2JvZgYK48jM2p9kJOFqKc6n3apnp62pRgSgPjYN3sP7hb/

firewall --enabled --ssh
selinux --permissive

timezone --utc Europe/London
unsupported_hardware
bootloader --location=mbr

# Disk Partitioning
zerombr
clearpart --all

# size = 39560 
part /boot --fstype ext4 --size=512
part swap --size=2048

part pv.01 --size=1 --grow
volgroup vg_root pv.01
logvol / --vgname vg_root --name root --size=15000
logvol /tmp --vgname vg_root --name tmp --size=1000
logvol /var --vgname vg_root --name var --size=10000
logvol /var/log --vgname vg_root --name log --size=5000
logvol /var/log/audit --vgname vg_root --name audit --size=5000
logvol /home --vgname vg_root --name home --size=1000

auth --useshadow --passalgo=sha512
bootloader --location=mbr --append="net.ifnames=0 biosdevname=0" --password='$6$16_qkqlsdjhfuiaz$10SpiiJ3LuAYBPCsq2ays.NO2azbmL.x1cIHjBGO2JvZgYK48jM2p9kJOFqKc6n3apnp62pRgSgPjYN3sP7hb/' --timeout=0
eula --agreed
services --enabled=network,sshd
reboot

%packages --excludedocs
@core --nodefaults

# unnecessary firmware
-aic94xx-firmware
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl100-firmware
-iwl105-firmware
-iwl1000-firmware
-iwl2000-firmware
-iwl2030-firmware
-iwl3160-firmware
-iwl135-firmware
-iwl7260-firmware
-iwl7265-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6000g2b-firmware
-iwl6050-firmware
-libertas-usb8388-firmware
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware
-mcstrans 
-telnet-server
-telnet 
-rsh-server
-rsh
-ypbind 
-ypserv
-tftp
-tftp-server
-talk-server
-xinetd 
-dhcp 
-NetworkManager*
%end

%post --log=/root/postinstall.log


# Preserve old network schemas
# ln -s /dev/null /etc/udev/rule.d/70-persistent-net.rules
rm -f /etc/sysconfig/network-scripts/ifcfg-eno*
rm -f /etc/sysconfig/network-scripts/ifcfg-ens*

# Set eth0 for provisioning
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOM
DEVICE=eth0
ONBOOT=yes
BOOTPROTO=dhcp
EOM


# Restart network
/etc/init.d/network restart

# Local admin
useradd admloc -U -m -p '$6$16_qkqlsdjhfuiaz$10SpiiJ3LuAYBPCsq2ays.NO2azbmL.x1cIHjBGO2JvZgYK48jM2p9kJOFqKc6n3apnp62pRgSgPjYN3sP7hb/'
useradd provisioner -U -m -p '$6$cemUfJ3uI5VDCg/o$nHj/HpUX2LLOJ4PLm/.MXS9x2T1AGLldSdgMLpWB5H0BFXeckPgJz/IPLEyFKtdXORSZStjx.a0NavdxL.2ak/'

# Add users to sudoers
echo "admloc	ALL=(ALL)	ALL" >> /etc/sudoers
echo "provisioner	ALL=(ALL)	ALL" >> /etc/sudoers


# Permit sudo tty for packer post-processor
sed -i 's/^Defaults    requiretty$/#Defaults    requiretty/' /etc/sudoers

%end
