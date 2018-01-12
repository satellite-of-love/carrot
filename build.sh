#!/bin/bash

restart_reason=$1

# be slow
sleep 10
cat monster.txt

echo $restart_reason

# this is super secret Team City magic to tell a later step that this succeeded
echo "##teamcity[setParameter name='secretmessage' value='Penguins LOL']"
# this is important
