# Setting up Development Env
## installation of Vagrant, Virtual box and Ruby
![](dev_env.png)

- To create a VM the dependencies we need are vagrant and virtual box and gitbash
- the aim for today, when we do vagrant up, all the things we did yesterday should execute automatically including installing packages and 'vagrant ssh'
- Vagrant has a method of syncing folders from our host os to our guest virtual machine. 

### environment/spec-tests >> `gem install bundler`
- `rake spec` returned failures
- `sudo apt-get install nodejs -y`
- `rake spec` again
- `curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs 
sudo apt-get install -y npm`
- `rake spec` again
- `sudo apt-get install python-software-properties -y`
- `sudo npm install -g pm2`
- `sudo npm install`
- `node app.js` inside the app folder
- check http://192.168.10.100:3000/ in the browser
- http://192.168.10.100:3000/fibonacci/13
- `export course=devops` create an environment variable
- `env` to check all. `printenv course` to check specific variable
- `ls -la ~/ | more` in home directory of VM to find the `.profile` file
- `nano .profile` and add `export DB_HOST=mongodb` start vm to see changes and `printenv DB_HOST`

- Add `sudo echo 'export DB_HOST=mongodb' >> .profile` directly in the `provision.sh` file. This is another option to add persistant variables

### Adding proxies
- `cd /etc/nginx/sites-available` default location of nginx
- delete the `default` file
- create an empty default file
- `server {
     listen 80;
     server_name _;
     location / {
          proxy_pass http://192.168.10.100:3000;
     proxy_http_version 1.1;
     proxy_set_header Upgrade $http_upgrade;
     proxy_set_header Connection 'upgrade';
     proxy_set_header Host $host;
     proxy_cache_bypass $http_upgrade;
     }
}`
- `sudo nginx -t` to check if syntax is ok
- go back to to /home/vagrant
- `sudo systemctl restart nginx` to run nginx from start, and check the browser (192.168.10.100) to see if its redirecting to app.js
- for troubleshooting: `ps aux` and `sudo kill` precesses that interfere with port 3000


### vagrant commands
- ` vagrant up` to launch the vm
- `vagrant destroy` to delete everything 
- `vagrant reload` to reload any new instruction in our `Vagrantfile`
- `vagrant halt` it poses the vm
- `vagrant status`

#### More commands can be found by typing `vagrant` on gitbash terminal and you'll see below outcome
```
Common commands:
     box             manages boxes: installation, removal, etc.
     cloud           manages everything related to Vagrant Cloud
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     hostsupdater
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     port            displays information about guest port mappings
     powershell      connects to machine via powershell remoting
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration
     resume          resume a suspended vagrant machine
     snapshot        manages snapshots: saving, restoring, etc.
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     upload          upload to machine via communicator
     validate        validates the Vagrantfile
     version         prints current and latest Vagrant version
     winrm           executes commands on a machine via WinRM
     winrm-config    outputs WinRM configuration to connect to the machine

For help on any individual command run `vagrant COMMAND -h`
```
- Let's `ssh` into our vm and launch nginx web-server
- use `apt-get` package manager in Linux - for mac `homebrew` or only `brew`
- `apt-get` is used to install and uninstall any packages needed
- To use the command in `admin` mode we can use `sudo` before the command
- `sudo apt-get upgrade -y`
- `sudo apt-get update -y`
- `ping www.bbc.co.uk`
- `sudo apt-get install name_of_the_package` 
- To work in an `admin mode` at all times (not recommonded) `sudo -su` and you'll land in admin mode
- We will install nginx in our guest machine/VM/ubuntu 16.04
- launch the default nginx page in host machine's browser
- To come out of your VM `exit`
- install nginx `sudo apt-get install nginx -y`
- checking status of nginx ` systemctl status nginx` 
- or restrat ` systemctl restart nginx` or just to start ` systemctl start nginx` 



- step 1: Install the plugin `vagrant plugin install vagrant-hostsupdater`
- step 2: vagrant destroy
- step 3: add this line of code into Vagrantfile `config.hostsupdater.aliases = ["development.local"]`
- step 4: vagrant up
- step 5: vagrant ssh
- step 6: repeat all the update and upgrade commands followed by installing nginx and checking of nginx
- `ningx status active` should load nginx in the browswer with `192.168.10.100` as well as `http://development.local/`

- if the `http://development.local/` doesn't work then try following debugging steps
- open a new `Gitbash termial` as `admin`
- `vagrant destroy`
- `rm -rf .vagrant`
- `vagrant up`

- Just in case if still doesn't work then try:
- `vagrant plugin uninstall vagrant-hostsupdater`
- update plugin with `vagrant plugin update vagrant-hostsupdater`
- open a new `Gitbash termial` as `admin`
- `vagrant destroy`
- `rm -rf .vagrant`
- `vagrant up`

#### Restart your machine after installing or updating the plugin

- if your machine isn't accepting the plugin and you can see nginx default page on `192.168.10.100` its fine for now
- Push your progress by 14:00 and share your repos please.

https://github.com/agiledivider/vagrant-hostsupdater



















