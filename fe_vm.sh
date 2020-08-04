#!/bin/bash
software_install() {
    sudo yum update -y
    curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
    sudo yum install httpd git nodejs -y
    }
frontend_config() {
    sudo setenforce 0
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    git clone --single-branch --branch master https://github.com/avvppro/final_project.git
    cd final_project/
    sudo npm install -g @angular/cli@7.0.7
    sudo npm install --save-dev  --unsafe-perm node-sass
    sudo npm install
    sudo ng build --prod
    sudo mv .htaccess dist/eSchool/
}
httpd_config() {
    sudo chown apache:apache /home/vagrant/final_project/dist/eSchool/
    sudo mv /home/vagrant/final_project/dist/eSchool/ /var/www/
    sudo mkdir /etc/httpd/sites-available /etc/httpd/sites-enabled
    sudo chmod 666 /etc/httpd/conf/httpd.conf /etc/httpd/sites-*
    sudo echo "IncludeOptional sites-enabled/*.conf" >>/etc/httpd/conf/httpd.conf
    sudo cat <<_EOF >/etc/httpd/sites-available/eschool.conf
<VirtualHost *:80>
    #    ServerName www.example.com
    #    ServerAlias example.com
    DocumentRoot /var/www/eSchool
    ErrorLog /var/log/httpd/eschool/error.log
    CustomLog /var/log/httpd/eschool/requests.log combined
    <Directory /var/www/eSchool/>
            AllowOverride All
    </Directory>
</VirtualHost>
_EOF
sudo chmod 644 /etc/httpd/conf/httpd.conf /etc/httpd/sites-*
sudo mkdir /var/log/httpd/eschool
sudo chown apache:apache /var/log/httpd/eschool
sudo ln -s /etc/httpd/sites-available/eschool.conf /etc/httpd/sites-enabled/eschool.conf
sudo systemctl restart httpd
}
software_install
frontend_config
httpd_config