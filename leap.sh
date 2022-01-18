#!/bin/bash

#This script is to test leap year or not.

	year=`date +%Y`
	if [ $[$year % 4] -eq 0 ]
	then 
	echo "This is a leap year"
	else
	echo "This is not a leap year"
	fi
