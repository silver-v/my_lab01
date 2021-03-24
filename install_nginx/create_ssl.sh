#!/bin/bash

clear_folder() {
   if [ -e /etc/nginx/ssl ] ;
   then 
      rm -R /etc/nginx/ssl
      mkdir /etc/nginx/ssl
   else
      mkdir /etc/nginx/ssl		
   fi
}

create_SSL() {
   openssl req -newkey rsa:2048  \
   -nodes \
   -days 365 \
   -x509 \
   -keyout /etc/nginx/ssl/private.key \
   -out /etc/nginx/ssl/cert.crt \
   -subj "/C=UA/ST=Kiev/L=Kiev/O=WEB/OU=IT Department/CN=www.site1.example.com"
}

assign_rights() {
   chown -R nginx:nginx /etc/nginx/ssl
   chmod -R 600 /etc/nginx/ssl
}


while true; do

   if [ -e /etc/nginx/ssl/private.key ] || [ -e /etc/nginx/ssl/cert.crt ] ;
   then	
       read -p "The certificate exists, do you want to replace it?" yn
       case $yn in
           [Yy]* ) create_SSL; assign_rights; break;;
           [Nn]* ) exit;;
           * ) echo "Please answer yes or no.";;
       esac
   else
      clear_folder
      create_SSL
      assign_rights
      break
   fi

done


echo "this is and"
