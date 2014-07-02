#!/bin/bash

COUNT=0
while :
do
    echo "Log entry $COUNT" >> /var/log/myapp.log
    COUNT=$(($COUNT+1))
    sleep 5
done
