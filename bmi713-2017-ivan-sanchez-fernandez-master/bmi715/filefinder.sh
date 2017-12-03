#!/bin/bash

##EXERCISE 2

#Assign arguments
argument1=$1
argument2=$2


#Check if the directory exists
if [ ! -d "$argument1" ];

	#If directory does not exist, print not a valid directory
	then 
	printf "%s is not a valid directory" $argument1

#If directory exists
else

	#And the file is found
	if [ -f "$argument1/$argument2" ];
		#If file found, then print that the file was found
		then 
		printf "%s was found in the directory %s" $argument2 $argument1

	#If the directory exists, but the file was not found
	else
		#Print that the file is not in the directory
		printf "%s is not in the directory %s" $argument2 $argument1

	#Close one loop
	fi

#Close the other loop
fi










