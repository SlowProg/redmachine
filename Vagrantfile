# -*- mode: ruby -*-
# vi: set ft=ruby :

boxname = "ubuntu-redmine"
env = "development"

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.synced_folder ".", "/home/vagrant/project", nfs: true

    config.vm.network "forwarded_port", guest: 3306, host: 3406

    config.vm.provider "virtualbox" do |vb|
        vb.name = boxname
        vb.memory = "2048"
    end

    config.vm.network "private_network", ip: "192.168.33.15"

    # config.vm.synced_folder "../data", "/vagrant_data"

    config.vm.provision "shell", path: "scripts/provision-system.sh"
    config.vm.provision "shell", path: "scripts/provision-ruby.sh", privileged: false
    config.vm.provision "shell", path: "scripts/provision-redmine.sh", args: [env], privileged: false
end
