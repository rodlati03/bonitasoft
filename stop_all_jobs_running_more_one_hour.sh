#!/bin/bash

TIME_LIMIT=3600

source init.sh

echo -e "**************** LAUNCHING script to stop all running job since $TIME_LIMIT seconds **************\n"
LIST_J_NAME=$(cat /tmp/result.txt | grep -B 3 -i _anime | grep name | awk '{print $3}' | sed -e "s/\,//g" | sed -e 's/\"//g')

for JOB_NAME in $LIST_J_NAME
do
	TIMESTAMP=$(curl -s -u rodlati03:$TOKEN_NAME "http://$JENKINS_URL/job/$JOB_NAME/lastBuild/api/json?tree=timestamp" | cut -d "," -f2 | cut -d ":" -f2 | sed -e "s/}//g")

	LAST_BUILD_TIME=$(date -d @$(( TIMESTAMP/1000 )) +%s)
	CURRENT_TIME=$(date +%s)
	DIFF_TIME=$(( CURRENT_TIME - LAST_BUILD_TIME ))
	echo "the LASTBUILD of job $JOB_NAME has been starting since $DIFF_TIME seconds"
	if [ $DIFF_TIME -gt $TIME_LIMIT ]
	then
		echo "the lastBuild job of $JOB_NAME is stopping..."
		curl -X POST -u rodlati03:$TOKEN_NAME http://$JENKINS_URL/job/$JOB_NAME/lastBuild/stop
		if [ $(echo $?) -eq 0 ]
		then
			echo "Job is stopped successfully !"
		else
			echo "there should be an error somewhere else"
		fi
	else
		echo "Job < $JOB_NAME > cannot stop because it doesn't reach the threshold"
	fi
done
