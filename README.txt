************************************
README 
************************************



The are a total of 8 scripts. Their operation will be described 
script by script.

--------------------------------

create_database.sh

Takes 1 parameter, $database
Creates the directory for the database $database

Example:

./create_database.sh myDB

--------------------------------

create_table.sh 

Takes 3 parameters - $database $table $columns
Creates file for $table with header $columns in directory $database
Input takes the form - "./create_table.sh newDB newTable column1,column2,column3,column4"

Example:

./create_table.sh myDB new_table column1,column2,column3

--------------------------------

insert.sh

Inserts given data into an already created table
Takes three inputs - $database $table tuple
If tuple matches table header, will be appended to the table

Example:

./insert.sh myDB new_table val1,val2,val3

--------------------------------

select.sh

Database query script
Takes 3 inputs - $database $table columns
Checks that database, table and columns exist

Example: 

./select.sh myDB new_table 1,2,3

--------------------------------

server.sh

Runs and maintains all the above scripts.

Takes input in the form of an input array up five variables long.
Runs given command matching a script an takes provides relevant variables.

Example:

./server.sh client_id command database_name
./server.sh 111 create_database myDB

--------------------------------

./client.sh

Starts the client process. Initally takes one input, user id
Then wait for commands to communicate with server process

Example:

./client.sh 1111
create_database myDB

--------------------------------

P.sh

Applies lock on file. Used internally for scripts.


--------------------------------

V.sh

Removes lock from file. Used internally for scripts.

--------------------------------

test_example.sh

A test script to ensure correct operation of each of the scripts when performing management of the database and the server. 








