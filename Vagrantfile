# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |appsrv|

  appsrv.vm.box = "/builds/centos7.4.box"
  appsrv.vm.hostname = "appsrv"
  appsrv.vm.box_check_update = false

  appsrv.ssh.username = "provisioner"
  appsrv.ssh.private_key_path = "packer/files/ssh_keys/provisioner.priv"
  #appsrv.vm.network "private_network", type: "dhcp"
  appsrv.vm.synced_folder ".", "/vagrant", disabled: true

  appsrv.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.cpus = 1
     vb.memory = "1024"
  end
  
  appsrv.vm.provision "ansible" do |ansible|
    ansible.force_remote_user = "provisioner"
    ansible.playbook = "hardenit.yml"
  end 

end
