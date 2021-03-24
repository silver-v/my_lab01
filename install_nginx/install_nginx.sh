#!/bin/bash

echo "--------- install nginx ----------"
yum install epel-release -y
yum install nginx -y
yum install wget -y
yum install git -y

systemctl enable nginx

echo "--------- config firewall --------"
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload


echo "--------- config nginx file --------"
rm /etc/nginx/nginx.conf

wget https://raw.githubusercontent.com/silver-v/my_lab01/main/install_nginx/template/nginx.conf.template -O /etc/nginx/nginx.conf

wget https://raw.githubusercontent.com/silver-v/my_lab01/main/install_nginx/template/server.conf.template -O /etc/nginx/conf.d/server.conf


echo "---------config WEB page --------"
rm -R /usr/share/nginx/html/*
rm -R /tmp/test_site

git clone https://github.com/silver-v/test_site.git /tmp/test_site/
mv /tmp/test_site/* /usr/share/nginx/html/
rm -R /tmp/test_site

echo "--------- config SSL --------"
pwd
./create_ssl.sh

echo "--------- start NGINX --------"
systemctl start nginx
