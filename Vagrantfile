# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "geerlingguy/ubuntu1604"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 8880, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.11"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # View the documentation for the provider you are using for more
  # information on available options.

  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.galaxy_role_file = "provisioning/requirements.yml"
    ansible.galaxy_roles_path = "/etc/ansible/roles"
    ansible.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force"
  end
  
  # Section for Graphical Desktop 
  if ENV['DEV_DESKTOP']
    config.vm.provider "virtualbox" do |vb|
	  # Display the VirtualBox GUI when booting the machine
	  vb.gui = true
	  # Customize the amount of memory on the VM:
	  vb.memory = "1024"
	end
	
	# Install xfce and virtualbox additions
	config.vm.provision "shell", inline: "sudo apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11"
	# Permit anyone to start the GUI
	config.vm.provision "shell", inline: "sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config"
	# Configure VBox guest tools
	config.vm.provision "shell", inline: "sudo VBoxClient --clipboard"
	config.vm.provision "shell", inline: "sudo VBoxClient --draganddrop"
	config.vm.provision "shell", inline: "sudo VBoxClient --display"
	config.vm.provision "shell", inline: "sudo VBoxClient --checkhostversion"
	config.vm.provision "shell", inline: "sudo VBoxClient --seamless"
  end
end
