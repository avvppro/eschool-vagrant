#!/bin/bash
set_variables() {
    database_ip="192.168.33.11"
}
software_install() {
    sudo yum update -y
    sudo yum install git wget java-1.8.0-openjdk-devel -y
    wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
    sudo tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
    sudo ln -s /opt/apache-maven-3.6.3/ /opt/maven
}
server_config() {
    cat <<_EOF >maven.sh
    export JAVA_HOME=/usr/lib/jvm/jre-openjdk
    export M2_HOME=/opt/maven
    export MAVEN_HOME=/opt/maven
    export PATH=/opt/apache-maven-3.6.3/bin:$PATH
_EOF
    chmod 777 maven.sh
    sudo mv maven.sh /etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh
    sudo setenforce 0
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
}
backend_config() {
    local_ip=$(ip addr show eth1 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
    git clone  https://github.com/avvppro/eSchool.git
    sed -i "s/my.db_address/$database_ip/g" ./eSchool/src/main/resources/application.properties
    sed -i "s/my.backend_address/$local_ip/g" ./eSchool/src/main/resources/application.properties
    sed -i "s/my.db_address/$database_ip/g" ./eSchool/src/main/resources/application-production.properties
    sed -i "s/my.backend_address/$local_ip/g" ./eSchool/src/main/resources/application-production.properties
    cd eSchool/
    mvn clean package -DskipTests
    java -jar target/eschool.jar &
}
set_variables
software_install
server_config
backend_config