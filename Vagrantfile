# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


  provider_is_libvirt = (!ARGV.nil? && ARGV.join('').include?('provider=libvirt'))
  
  unless(provider_is_libvirt)
     config.vm.box = "ubuntu/trusty64"
     config.vm.provider "virtualbox" do |vb|
       vb.customize ["modifyvm", :id, "--memory", "2048"]
     end
  end
	
	
  if (provider_is_libvirt)	
    config.vm.define :docker do |docker|
      docker.vm.box = "ubuntu/trusty64"
      docker.vm.provider :libvirt do |domain|
        domain.memory = 4096
        domain.cpus = 2
        domain.nested = true
        domain.volume_cache = 'none'
      end
    end
    config.vm.provider :libvirt do |libvirt|
      libvirt.storage_pool_name = "images"
    end
  end

  config.vm.synced_folder "srv/", "/srv/"
  config.vm.provision :salt do |salt|
    salt.minion_config = "minion"
    salt.run_highstate = true
    salt.install_type = "stable"
    salt.bootstrap_options = "-F -c /tmp/ -P"
  end


   config.vm.network "forwarded_port", guest: 8088, host: 8088
   config.vm.network "forwarded_port", guest: 9090, host: 9090

 
end
