sleep 10
cat monster.txt

exit 1 #failinate!!

# this is super secret Team City magic to tell a later step that this succeeded
echo "##teamcity[setParameter name='secretmessage' value='Penguins LOL']"