#!/bin/bash

export TOKEN_NAME=$(cat /tmp/remote_token)

curl http://localhost:8080/api/json?pretty -u rodlati03:$TOKEN_NAME > /tmp/result.txt

echo -e "********* here are the list of the current running jobs on your jenkins server ********\n"

cat /tmp/result.txt | grep -B 3 -i _anime | grep name | awk '{print $3}' | sed -e "s/\,//g" | sed -e 's/\"//g'
