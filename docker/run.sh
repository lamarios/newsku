#!/usr/bin/env bash
RAM=${MAX_RAM:-256m}
echo "Starting Newsku with max RAM = ${RAM}"
java -XX:MaxRAM=${RAM} -jar /app/newsku.jar