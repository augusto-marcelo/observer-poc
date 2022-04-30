#!/bin/bash

DOCKER_INSTALL_SCRIPT_URL="https://get.docker.com"
DOCKER_COMPOSE_URL="https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)"
APACHE_MAVEN_TAR_URL="https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz"

REQUIRED_TOOLS="git curl wget"

# Directory structure
DOWNLOAD_DIR="/tmp/provisioning_files"
JAVA_DIR="/opt/java/"
MVN_DIR="/opt/maven"


function stage_zero() {
    echo "#### Starting stage 0: ... ####"
    
    #update pkg manager
    apt update -y
    apt install -y $REQUIRED_TOOLS

    # create base directory structure
    mkdir -p $DOWNLOAD_DIR
    mkdir -p $JAVA_DIR
    mkdir -p $MVN_DIR

    cp -r /vagrant/tmp/observer_realm /root/
    chown -R root:root /root/observer_realm

    # Configure bashrc
    cp /vagrant/tmp/observer_realm/bashrc /root/.bashrc

    # Configure timezone
    timedatectl set-timezone Europe/Lisbon

    echo "#### Stage 0 completed succesfully ###"
}

function stage_one() {
    echo "#### Starting stage 1: ... ####"

    cd $DOWNLOAD_DIR
    curl -fsSL $DOCKER_INSTALL_SCRIPT_URL -o get-docker.sh
    curl -L $DOCKER_COMPOSE_URL -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
    wget $APACHE_MAVEN_TAR_URL

    echo "#### Stage 1 completed succesfully ###"
}

function stage_two() {
    echo "#### Starting stage 2: .... ####"

    cd $DOWNLOAD_DIR
    
    sh get-docker.sh
    
    tar xzvf apache-maven-3.8.5-bin.tar.gz
    mv apache-maven-3.8.5 $MVN_DIR/apache-maven-3.8.5

    cp /vagrant/tmp/observer_realm/jdk-8u202-linux-x64.tar.gz $DOWNLOAD_DIR
    tar xzvf jdk-8u202-linux-x64.tar.gz
    mv jdk1.8.0_202 $JAVA_DIR
    

    echo "#### Stage 2 completed succesfully ###"
}

function stage_three() {
    echo "#### Starting stage 3: .... ####"

    cd /root/observer_realm
    docker-compose up -d

    echo "#### Stage 3 completed succesfully ###"
}

function main() {

    stage_zero
    stage_one
    stage_two
    stage_three

}

main

### TO-DO
## Fix date and time by:
#       1 - Adjust the timezone on timedatectl [DONE]
#       2 - Enable ntp service 
#       3 - Configure timezone servers
#       4 - Make sure ntp service is running