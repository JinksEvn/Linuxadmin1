#!/bin/sh

#Installing httpd
yum install -y httpd
echo "Installed httpd"

#start the httpf service
systemctl start httpd

#firewall to web server
firewall-cmd --permanent --add-port=80/tcp

#firewall to web server
firewall-cmd --permanent --add-port=443/tcp

#reload the firewall
firewall-cmd --reload

#enable the httpd  
systemctl enable httpd

#Installing fedoraproject
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
echo "Installed fedoraproject "

#Installing the remirepo
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
echo "Installed remirepo"

#Installing yum-utis
yum install -y yum-utils
echo "Installed yum-utils"

#
yum-config-manager --enable remi-php56

#
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

#restart the web server
systemctl restart httpd

#Installing mariadb-server
yum install -y mariadb-server mariadb
echo "mariadb-server"

#To start mariadb
systemctl start mariadb



# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"

# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"

# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"

# Kill off the demo database
mysql -e "DROP DATABASE test"

# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param


systemctl enable mariadb