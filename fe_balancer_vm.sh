#!/bin/bash
software_install() {
    sudo yum update -y
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
    sudo yum install mc nginx setroubleshoot-server -y    
}
nginx_config() {
 semanage permissive -a httpd_t
    cat <<_EOF >./frontend_lb.conf 
    upstream frontend { 
        ip_hash;
        server 192.168.33.201:80;
        server 192.168.33.202:80;
    }
    server {
        listen       80;
        server_name  192.168.33.250;
        location /{
            proxy_pass http://frontend;
        }
    }
_EOF
    sudo mv ./frontend_lb.conf /etc/nginx/conf.d/
    sudo systemctl start nginx
    sudo systemctl enable nginx
}
software_install
nginx_config