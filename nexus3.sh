#!/bin/bash
#Installation in ubuntu 18.04
#Nexus installation supports as non-root user only.

#Nexus installation works with java-1.8 only not latest versions

#Nexus installation requires a minimum of 4gb RAM for efficient performance

java -version 2>> java-error.log

if [ $? -eq 0 ] #whether java is installed or not
then
	echo "Java is installed"
	echo "Check whether installed java version is 1.8"
elif [ $? -ne 0 ]
then
	echo "Installing java version 1.8"
	sudo apt update && sudo apt install -y openjdk-8-jre-headless
	if [ $? -eq 0 ] 
	then 
		echo "Java 1.8 is installed"
	else
		echo "Java 1.8 is not installed properly. Please install properly"
	fi
fi

#Installing nexus3

echo "* * * Installing nexus3 * * *"
echo
cd /opt

if [ -d /opt/nexus3 ]
then
	echo "nexus3 is already installed"
	echo
else
	echo "* * * nexus3 will install now !!* *  *" 
	sudo wget https://download.sonatype.com/nexus/3/nexus-3.37.3-02-unix.tar.gz   #Check for latest
	echo
	if [ -f nexus-3.37.3-02-unix.tar.gz ]
	then
		echo "Download is successful"
		echo "Extracting the file"
		sudo tar -xzvf nexus-3.37.3-02-unix.tar.gz
		if [ $? -eq 0 ] 
		then
			echo "* * *Extraction successful* * *"
			sudo mv nexus-3.37.3-02 nexus3 
		else
			echo
			echo "* * *Extraction unsuccessful* * *"
			echo
		fi
	fi
fi


