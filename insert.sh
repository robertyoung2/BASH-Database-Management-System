#!/bin/bash

# Inserts given data into an already created table
# Takes three inputs - $database $table tuple
# If tuple matches table header, will be appended to the table

database_dir=$1
newTable=$2
tuple=$3

# Count the number commas in the table header
table_columns=$(awk -F"," ' { print NF-1 } ' $database_dir/$newTable | head -n 1)

# Count the number of commas in the input tuple
tuple_columns=$(echo $tuple | awk -F\, '{ print NF-1}')

# "Error: parameters problem"

if [ $# -ne 3 ]; then
	echo "Error: Parameter problem. Please enter 3 - database, table, tuple."
	#echo "Error: Parameter problem. Please enter 3 - database, table, tuple." >&2
	exit 10

# "Error: DB does not exist"

elif ! [ -d $database_dir ]; then
	echo "Error: DB does not exists"
	#echo "Error: DB does not exists" >&2
	exit 2

# "Error: table does not exist"

elif ! [ -f $database_dir/$newTable ]; then
	echo "Error: Table does not exists"
	#echo "Error: Table does not exists" >&2
	exit 30

# "Error: number of columns in tuple does not match schema"
elif ! [ $table_columns -eq $tuple_columns ]; then
	echo "Error: number of columns in tuple does not match schema."
	exit 4

# Count the number commas in the table header
else
	./P.sh $database_dir/$newTable
	# if the number of commas is equal, add the tuple as a row to the end of the table
	if [ $table_columns -eq $tuple_columns ]; then
		echo "$tuple$APPEND" >> $database_dir/$newTable
		echo "OK: tuple inserted"
	fi
	./V.sh $database_dir/$newTable

fi 