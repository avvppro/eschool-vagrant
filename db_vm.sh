#!/bin/bash
software_install(){
sudo yum update -y
sudo yum install wget -y
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum localinstall mysql57-community-release-el7-11.noarch.rpm -y
sudo yum-config-manager --enable mysql57-community
sudo yum install mysql-community-server -y
sudo yum install expect -y
sudo systemctl start mysqld 
sudo systemctl enable mysqld 
}
database_config(){
cat <<_EOF >./my.expect 
#!/usr/bin/expect -f
set timeout 3
spawn mysql -u root -p
expect "Enter password:"
send "[lindex \$argv 0]
"
sleep 1
expect "mysql>"
send "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RootPWD1@';
"
sleep 1
expect "mysql>"
send "CREATE DATABASE eschool DEFAULT CHARSET = utf8 COLLATE = utf8_unicode_ci;
"
sleep 1
expect "mysql>"
send "CREATE USER 'username'@'%' IDENTIFIED BY 'passwordQ1@';
"
sleep 1
expect "mysql>"
send "GRANT ALL PRIVILEGES ON eschool.* TO 'username'@'%'  WITH GRANT OPTION;
"
sleep 1
expect "mysql>"
send "exit
"
_EOF

sudo chmod 777 ./my.expect
sudo grep 'temporary password' /var/log/mysqld.log | sed 's|.*: ||' >1.txt
tmp_pass=$(cat 1.txt)
sudo ./my.expect $tmp_pass
rm my.expect 1.txt
local_ip=$(ip addr show eth1 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
sudo chmod 666 /etc/my.cnf
sudo echo "bind-address=$local_ip" >>/etc/my.cnf
sudo chmod 644 /etc/my.cnf
}
software_install
database_config