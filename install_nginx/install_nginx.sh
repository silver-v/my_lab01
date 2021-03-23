#!/bin/bash

echo "install nginx"
yum install epel-release -y
yum install nginx -y

systemctl start nginx
systemctl enable nginx

echo "config firewall"
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload
