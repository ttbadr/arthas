#!/bin/bash
# get script dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PID=$1
if [ -z "$PID" ]; then
   echo "Usage: jattach.sh <PID>"
   exit 1
fi

cd $DIR
chomod u+x jattach
java -jar arthas-client.jar 127.0.0.1 3658
if [ $? -eq 1 ]; then
    echo "agent not started, try to start it"
    ./jattach $PID load instrument false "$DIR/arthas-agent.jar" && java -jar arthas-client.jar 127.0.0.1 3658
fi
