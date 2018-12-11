#!/bin/bash

# Database query script
# Takes 3 inputs - $database $table columns
# Checks that database, table and columns exist

database_dir=$1
newTable=$2
columns=$3

table_columns=$(awk -F"," ' { print NF-1 } ' $database_dir/$newTable | head -n 1)
table_columns_count=$((table_columns+1))
# Error: parameters problem

if [ $# -lt "2" ] || [ $# -gt "3" ]; then
	# echo "Error: Parameter problem. Please enter 2 or more - database, table, columns." >&2
	echo "Error: Parameter problem. Please enter more than 2 and less than 4 - database, table, columns."
	exit 10

# Error: DB does not exist

elif ! [ -d $database_dir ]; then
	#echo "Error: DB does not exist" >&2
	echo "Error: DB does not exist" 
	exit 2


# Error: table does not exist

elif ! [ -f $database_dir/$newTable ]; then
	#echo "Error: Table does not exists" >&2
	echo "Error: Table does not exists" 
	exit 30

elif [ -z $3 ] ; then
		./P.sh $database_dir/$newTable
		echo "start_result"
		cat $database_dir/$newTable
		echo "end_result"
		./V.sh $database_dir/$newTable
else

	./P.sh $database_dir/$newTable
	# Create array of user input
	IFS="," read -r -a array <<< "$3"

	# Store max and min values from array
	IFS=$'\n'
	max=$(echo "${array[*]}" | sort -nr | head -n1)
	min=$(echo "${array[*]}" | sort -n | head -n1)

	if [ $max -le $table_columns_count ] && [ $min -ge 1 ] ;then
		

		echo "start_result"
		
		table_data=`cut -d "," -f $3 < $database_dir/$newTable`
		for line in $table_data; do

			for arg in "${array[@]}"; do
				echo "$line" | cut -d ',' -f "$arg" | tr '\n' ', ' >> select_out.txt
			done

			echo "" >> select_out.txt
		done

		sed 's/,$//' "select_out.txt" >> select_out_sed.txt
		rm select_out.txt
		
		cat select_out_sed.txt
		rm select_out_sed.txt

		echo "end_result"

	else
		echo "Error: column does not exist"
	fi
	./V.sh $database_dir/$newTable
fi 