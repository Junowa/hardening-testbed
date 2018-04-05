# Hardening testbed

* Create centos7 vagrant box with packer virtualbox-iso
* Test ansible hardening role

Before running vagrant install hardening role :
```
$ ansible-galaxy install git+https://github.com/openstack/ansible-hardening
```

```
$(packer) packer build
$(hardening-testbed) vagrant up
# Provision only
$(hardening-testbed) vagrant provision
```

Note : vagrant needs password-less sudo
