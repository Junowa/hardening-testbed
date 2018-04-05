# Hardening testbed

* Create centos7 vagrant box with packer virtualbox-iso
* Test ansible hardening role


```
$(packer) packer build
$(hardening-testbed) vagrant up

```

Note : vagrant needs password-less sudo
