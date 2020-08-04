#!/bin/bash
software_install() {
    sudo yum update -y
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
    sudo yum install git wget mc nginx -y    
}
nginx_config() {
    sudo setenforce 0
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    git clone --single-branch --branch avvppro https://github.com/avvppro/IF-108.git
    sudo mv IF-108/task2/nginx.conf /etc/nginx/nginx.conf
    sudo chown root. /etc/nginx/nginx.conf
    sudo chmod 644 /etc/nginx/nginx.conf
    sudo systemctl start nginx
    sudo systemctl enable nginx
}
software_install
nginx_config