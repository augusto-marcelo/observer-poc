Vagrant.configure("2") do |config|
  config.vm.box = "debian/buster64"
  
  
  config.vm.define "alura-observer-5" do |pgr1|
    pgr1.vm.hostname = "observer05"
    pgr1.vm.network "private_network", ip: "192.168.56.20" #bridge: 'wlp3s0' 
    pgr1.vm.provision "shell", path: "initial_setup.sh"

    pgr1.vm.provider "virtualbox" do |p1|
        p1.name = "alura-observer-5"
        p1.gui = false
        p1.memory = 2048
        p1.cpus = 2
    end 

  end
  
end
