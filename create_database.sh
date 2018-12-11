#!/bin/bash

# Takes 1 parameter, $database
# Creates the directory for the database $database

dir_name=$1

# No parameter provided check - "Error: no parameter"

if [ $# -ne 1 ]; then
	echo "Error: no parameter"
	# echo "Error: no parameter" >&2 # redirect standard output, file descriptor, standard error
	exit 1

# The database already existed - "Error: DB already exists"
./P.sh create_database.sh

elif [ -d $dir_name ]; then
	echo "Error: DB already exists"
	# echo "Error: DB already exists" >&2
	exit 2

# Everything went well - "OK: database created" "Lock here as critical section"

else
	mkdir -p $dir_name
	echo "OK: database created"
	exit 0
fi 
./V.sh create_database.sh