#!/bin/bash

#This is only a installation script

#The following script intends to automate the installation of sonar web server application in ubuntu 18.04 and t2.medium instance type

#All the installation must begin with sudo and as ubuntu not as root user

if [ `whoami` = "ubuntu" ]
then
	echo "SonarQube installation can proceed now"
else
	echo "Permission denied. Try as ubuntu or you must be lucky !!"
fi

#Checking whether java is installed or not

java -version 2>> java_error.log

if [ $? -eq "0" ]
then
        echo "* * * Java is already installed * * *"
else
	echo
	echo "* * * Installing latest version of java * * *"
	echo
	sudo apt-get update && sudo apt-get install -y default-jdk
fi

#Installing sonarqube

if [ -d /opt/sonarqube ] #checks if the sonarqube is installed or not
then
	echo "* * *sonarqube is already installed* * *"
else
	echo "* * * ......Installing sonarqube * * *"
	sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.6.0.39681.zip
	sudo apt-get install -y unzip
	sudo unzip sonarqube*.zip -d /opt
	sudo mv /opt/sonarqube-8.6.0.39681 /opt/sonarqube -v
	if [ $? -eq "0" ]
	then
		echo
		echo "* * * sonarqube installation is successful * * *"
		echo
		echo "Install Postgresql database"
	fi
fi

#Installing Postresql database 

if [ -d /var/lib/postgresql ] #checks if postgresql is installed or not
then
	echo "* * *Postgresql is already installed* * *"
else
	echo 
	echo "* * * ....Installing Postgresql * * *"
	sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
	sudo wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
	sudo apt-get -y install postgresql postgresql-contrib
	if [ $? -eq "0" ]
	then 
		echo
		echo "* * * Postgresql is successfully installed * * *"
		sudo systemctl start postgresql
		sudo systemctl enable postgresql
	fi
fi

#Switching to postgres 

name=`cat /etc/passwd | tail -3 | awk -F ":" '$1 ~ /postgres/ {print $1}'`
if [ $name == "postgres" ]
then
	echo "* * * Switching to postgres user * * *"
	sudo su - postgres
else
	echo "postgres user not created. Check relevant file or try manually"
fi

#Automation ends here

#Now we have to manually install the following 


#createuser username(our choice)
#psql (switching to sql shell)
#
#Execute the below commands in sql shell to create the database schema
#ALTER USER username(our choice as above) WITH ENCRYPTED password 'password'(our choice);

#CREATE DATABASE database_name(our choice) OWNER username(as assigned above);

#GRANT ALL PRIVILEGES ON DATABASE database_name to username;
#\q (come out of sql shell)
#type exit

#This is not the end of process further manually create group and user and give permissions to /opt/sonarqube directory

#sudo groupadd group_name(ourchoice)
#sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g group_name username 
#sudo chown username:group_name /opt/sonarqube -R


#Do changes in the sonar.properties in /opt/sonarqube/conf

#Edit the  sonar script file to change the RUN_AS_USER

#To enable automatic restart of sonarqube service we should configure a systemd file as zip folder cannot create service start file

#Make kernel changes in /etc/sysctl.conf

#Edit the /etc/security/limits.conf 

#Reload system level changes 

#Start the sonarqube service now
