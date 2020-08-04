# Deploy eSchool app (database+backend+frontend)

## Sources forked from https://github.com/yurkovskiy

### Software
Vagrant 2.2.9
VirtualBox 6.1.12

### Functionality
Create  1 Database 2 Backend 2 Frontend 2 Balancers (BE+FE) from the box. 

## For update:
* Insert credentials in Vagrantfile
* Check Database ip in db_vm.sh and be_vm.sh
* Check Backend ip address range in be_balancer_vm.sh
* Check Backend balancer ip in fe_vm.sh
* Check Frontend ip address range in fe_balancer_vm.sh

#### Run
* Run "vagrant up" and Chill (^^,)

##### For login go to http://192.168.33.200 in browser
