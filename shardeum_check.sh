#!/bin/bash
while :
do
docker exec shardeum-dashboard operator-cli status | grep stopped
if [ $? -eq 0 ]
then
        echo $(date)
        echo "START SHARDEUM"
        docker exec shardeum-dashboard operator-cli start
fi
sleep 1m
done
