#!/usr/bin/env bash
RAM=${MAX_RAM:-256m}
echo "Starting Newsku with max RAM = ${RAM}"
java -Xms32m -Xmx${RAM:-512m} -XX:+IdleTuningGcOnIdle -XX:IdleTuningMinIdleWaitTime=120 -jar /app/newsku.jar