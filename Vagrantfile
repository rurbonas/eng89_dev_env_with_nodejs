# ruby syntax

# code to check if persistent variable exists and if not create it
def set_env vars
  command = <<~HEREDOC
    echo "Setting Environment Variables"
    source ~/.bashrc
  HEREDOC

  vars.each do |key, value|
    command += <<~HEREDOC
      if [ -z "$#{key}" ]; then
        echo "export #{key}=#{value}" >> ~/.profile
      fi
    HEREDOC
  end

  return command
end

# create our VM/VMs
Vagrant.configure("2") do |config|
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.150"
    db.vm.synced_folder "db", "/home/vagrant/db"
    db.vm.provision "shell", path: "provisiondb.sh"

  end
  
  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"  
    app.vm.network "private_network", ip: "192.168.10.100"
    app.vm.synced_folder "app", "/home/vagrant/app"
    app.vm.synced_folder "environment", "/home/vagrant/environment"
    app.vm.provision "shell", path: "provision.sh", env: {'DB_HOST' => 'mongodb://192.168.10.150:27017/posts'}
      
  end



end

