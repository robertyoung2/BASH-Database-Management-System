#!/bin/bash

if [ ! -f server.pipe ]; then
    mkfifo server.pipe
fi

function exit_now() {
	echo "Server is shutting down."
	rm -f server.pipe
}

while true; do

	trap exit_now EXIT

	read -a input_array < server.pipe

	client_id=${input_array[0]}
	command=${input_array[1]}
	second=${input_array[2]}
	third=${input_array[3]}
	fourth=${input_array[4]}

	case "$command" in 

		# Create Database - create_database.sh 
		# One parameter $database
		"create_database")
			echo "About to create database via create_database.sh"
			./create_database.sh $second > "$client_id.pipe" & sleep 1
			;;
			
	# Create Table - create_table.sh
	# Three parameters $database $table $columns
		"create_table")
			echo "About to create table via create_table.sh"
			./create_table.sh $second $third $fourth > "$client_id.pipe" & sleep 1
			;;

	# Insert Data - insert.sh $database $table tuple
		"insert")
			echo "About to insert into table via insert.sh"
			./insert.sh $second $third $fourth > "$client_id.pipe" & sleep 1
			;;

	# Select Data - select.sh $database $table columns

		"select")
			echo "About to select data via select.sh"
			./select.sh $second $third $fourth > "$client_id.pipe" & sleep 1
			;;

		"shutdown")
			exit_now > "$client_id.pipe"
			exit 0
			;;

		# Bad Request - no matching command
		*)
			echo "Error: bad request"
			exit 1

	esac 
done

