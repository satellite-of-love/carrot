#!/bin/bash

restart_reason=$1

sleep 10
cat monster.txt

echo $restart_reason
##exit 1 #failinate!! no more penguins


# this is super secret Team City magic to tell a later step that this succeeded
echo "##teamcity[setParameter name='secretmessage' value='Penguins LOL']"