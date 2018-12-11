#!/bin/bash

# client.sh

close_client=1

function client_exit() {
	if [ "$close_client" -eq 1 ]; then
		echo "client closing"
		rm "$client_id.pipe" 

		exit 0
	else
		echo "$message_from_server"
		rm "$client_id.pipe" 
	fi
}

if [ $# -ne 1 ]; then
	#echo "Error: please enter only one parameter for id" >&2 # redirect standard output, file descriptor, standard error
	echo "Error: please enter only one parameter for id"
	exit 1

# In loop, read request of form req $id

else
	client_id="$1"
	mkfifo "$client_id.pipe"

	trap client_exit EXIT

	while true; do

		read command

		if [ "$command" = "exit" ] ; then
			close_client=1
			exit 0
		else
			echo $client_id $command > server.pipe	
			read -d '' message_from_server < "$client_id.pipe"
			if [ "$message_from_server" = "Server is shutting down." ]; then
				close_client=0
			else
				echo "$message_from_server"
			fi
		fi	
	done 

fi
