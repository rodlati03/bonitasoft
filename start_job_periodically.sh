#!/bin/bash

JOB_NAME=$1
#JOB_NAME="running_custom_job"

[[ $JOB_NAME == "" ]] && echo "Please try again by adding JOB_NAME as arg"

source init.sh 

curl -X POST http://$JENKINS_URL/job/$JOB_NAME/build? -u rodlati03:$TOKEN_NAME
result=$(echo $?)

if [ $result -eq 0 ]
then
	echo "the remote build of job $JOB_NAME has been successfully run !!!"
else
	echo "There is an issue while launching the job"
	exit 1

fi
