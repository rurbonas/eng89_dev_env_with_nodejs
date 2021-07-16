!#/bin/bash

# upgrade and update
sudo apt-get update -y
sudo apt-get upgrade -y

# install dependencies
sudo apt-get install nginx -y
sudo apt-get systemctl restart nginx
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs 
sudo apt-get install -y npm
sudo apt-get install python-software-properties -y
sudo npm install -g pm2
cd app/
sudo npm install -y

# navigate and delete the file, then create a new file with necessary amendments
cd /etc/nginx/sites-available
sudo rm -rf default
sudo echo "server{
        listen 80;
        server_name _;
        location / {
        proxy_pass http://192.168.10.100:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        }
}" >> default

# restart nginx
sudo nginx -t
sudo systemctl restart nginx
export DB_HOST=mongodb://192.168.10.150:27017/posts >> ~/.profile




