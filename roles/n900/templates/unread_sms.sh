#!/bin/sh

#SQLEXEC="sqlite3 -header /home/user/.rtcom-eventlogger/el-v1.db"
sqlexec () {
    query="$1"
    sqlite3 -separator "" "/home/user/.rtcom-eventlogger/el-v1.db" "$query"
}

SQLQUERY="Select
    '<b>From: </b>', remote_uid, ' ',
    '<b>Date: </b>', datetime(storage_time, 'unixepoch', 'localtime'), '\n',
    free_text
    from Events
    where service_id=3 and is_read=0 and outgoing=0 order by storage_time desc"
#    free_text, is_read, storage_time from Events

sqlexec "$SQLQUERY" 2>&1
