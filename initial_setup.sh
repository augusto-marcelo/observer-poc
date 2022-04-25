#!/bin/bash

apt update -y

apt install -y git curl wget

curl -fsSL https://get.docker.com -o get-docker.sh

sh get-docker.sh

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

## Java jdk 1.8 from https://jdk.java.net/java-se-ri/8-MR3
#https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz

# Maven from https://maven.apache.org/download.cgi
# https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz


####
## Need to add this to the /root/.bashrc file
####
#export JAVA_HOME="/opt/java-se-8u41-ri"
## Maven
#export M2_HOME="/opt/apache-maven-3.8.5"
#export M2="$M2_HOME/bin"
#export PATH="$PATH:$JAVA_HOME/bin"
#export PATH="$PATH:$M2"

### TO-DO
## Fix date and time by:
#       1 - Adjust the timezone on timedatectl
#       2 - Enable ntp service 
#       3 - Configure timezone servers
#       4 - Make sure ntp service is running