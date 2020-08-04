
BOX_IMAGE = "centos/7"
Vagrant.configure("2") do |config|
        config.vm.define "database" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "db_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.33.11"
            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "512"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "db_vm.sh"
        end
        config.vm.define "backend" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "be_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.33.102"
            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "1536"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "be_vm.sh"
        end
        config.vm.define "frontend" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "fe_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.33.103"
            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "1536"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "fe_vm.sh"
        end
        config.vm.define "proxy" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "proxy_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.33.200"
            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "1024"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "proxy_vm.sh"
        end
end
