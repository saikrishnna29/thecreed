#!/bin/bash

#To install tomcat9 on Amazon Linux 2
#It supports java version 11

java -version 2>> java-error.log

if [ $? -eq 0 ] #whether java is installed or not
then
        echo
	echo "Java is installed"
        echo "Check whether installed java version is 11 or else switch to java version 11"
elif [ $? -ne 0 ]
then
        echo "* * * Installing java version 11 * * *"
        sudo amazon-linux-extras install -y java-openjdk11 
        if [ $? -eq 0 ]
        then
                echo "Java 11 is installed"
        else
                echo "Java 11 is not installed properly. Please install properly"
        fi
fi

#Installing tomcat9

echo "* * * Installing tomcat9 * * *"
echo
cd /usr/local/

if [ -d /usr/local/tomcat9 ]
then
        echo "tomcat9 is already installed"
        echo
else
        echo "* * * tomcat9 will install now !! * *  *"
        sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58.tar.gz   #Check for latest
        echo
        if [ -f apache-tomcat-9.0.58.tar.gz ]
        then
                echo "Download is successful"
                echo "Extracting the file"
                sudo tar -xzvf apache-tomcat-9.0.58.tar.gz
                if [ $? -eq 0 ]
		then
                        echo "* * *Extraction successful* * *"
                        sudo mv apache-tomcat-9.0.58 tomcat9
                else
                        echo
                        echo "* * *Extraction unsuccessful* * *"
                        echo
                fi
        fi
fi                                                                                    
