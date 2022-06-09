#!/bin/sh

#Installing httd
install -y httpd
echo "Installed httpd"

#To start teh service
systemctl start httpd

#To add the firewall rule
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp

#To reload the firewall
firewall-cmd --reload

#Enable httpd as a servive
systemctl enable httpd

#Installing fedoraproject
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
echo "Installed fedora"

#Installing remirepo
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
echo "Installed remirepo"

#Installing Utilities
yum install -y yum-utils
echo "Installed Utilities"

#Enabling remi=php56
yum-config-manager --enable remi-php56

#Installing php
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
echo "Installed php and more"

#To start service
systemctl restart httpd

#Installing MariaDB-server
yum install -y mariadb-server mariadb
echo "Installed MariaDB"

#To start MariaDB
systemctl start mariadb
echo "Starting MariaDB"

mysql_secure_installation <<EOF

y
jinks
jinks
y
y
y
y
EOF

#To enable MariaDB
systemctl enable mariadb

#Creating a database
mysql -u root -pjinks -e "CREATE DATABASE wordpress;"
mysql -u root -pjinks -e "CREATE USER wordpressuser@localhost IDENTIFIED BY 'espino';"
mysql -u root -pjinks -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'espino';"
mysql -u root -pjinks -e "FLUSH PRIVILEGES;"

#This command will go to home directory
cd ~

#Installing wget
yum install -y wget
echo "Installed wget"

#this command is to zip
wget http://wordpress.org/latest.tar.gz

#This command Extract files
tar xzvf latest.tar.gz

#Installing Rsync
yum install -y rsync
echo "Installed Rsync"

#This command for transferring
rsync -avP ~/wordpress/ /var/www/html/

#This command to create a folder
mkdir /var/www/html/wp-content/uploads

#To change the ownership of var,www,html and all
chown -R apache:apache /var/www/html/*

#To navigate
cd /var/www/html/

#This command use to specify the expression of the script
cat wp-config-sample.php | sed -e 's/database_name_here/wordpress/g' | sed -e 's/username_here/wordpressuser/g' | sed -e 's/password_here/espino/g' > wp-config.php