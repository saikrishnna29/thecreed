#!/bin/bash

#The script is intended to automate installation of jenkins 

#The following commands have been copied from the jenkins official website and must be executed in order

	if [ `whoami` != "root" ]
		then
		echo "Permission denied. Try as root-user or you must be lucky"
	else
		echo "The installation will begin"
		yum update -y
		wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo 
		rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
		amazon-linux-extras install -y epel #Installs daemon
		amazon-linux-extras install -y java-openjdk11
 		yum install -y jenkins
		if [ $? -eq "0" ]
		then 
			echo "Installation is successful"
			echo "Start Jenkins"
		fi
	fi 
