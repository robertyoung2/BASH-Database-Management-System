#!/bin/bash

./server.sh > serverout &
sleep 1
echo -e -n "create_database test_db\ncreate_table test_db test_table c1,c2,c3\ninsert test_db test_table v1,v2,v3\nselect test_db test_table 1,2,3\nshutdown\nexit" | ./client.sh admin > clientout &
