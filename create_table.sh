#!/bin/bash

# Takes 3 parameters - $database $table $columns
# Creates file for $table with header $columns in directory $database
# Input takes the form - "./create_table.sh newDB newTable column1,column2,column3,column4"

database_dir=$1
newTable=$2
columns=$3

# Too few or many parameters - "Error: parameters problem"

if [ $# -ne 3 ]; then
	echo "Error: Parameter problem. Please enter 3 - database, table, columns."
	# echo "Error: Parameter problem. Please enter 3 - database, table, columns." >&2
	exit 10

# Database does not exist - "Error: DB does not exist"

elif ! [ -d $database_dir ]; then
	echo "Error: DB does not exist" 
	# echo "Error: DB does not exist" >&2
	exit 20

# The table already exists - "Error: table already exists"
# Need to enter directory and check for file

./P.sh create_table.sh
elif [ -f $database_dir/$newTable ]; then
	echo "Error: table already exists"
	# echo "Error: table already exists" >&2
	exit 3

# Everything went well - "OK: table created"
else

	echo $columns | column  -t > $database_dir/$newTable
	echo "OK: table created"
	exit 0
fi 

./V.sh create_table.sh