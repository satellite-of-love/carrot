#!/bin/bash

tcbaseurl=$1 # "teamcity.nvidia.com"
echo "tcbaseurl=$tcbaseurl"
buildid=$2 # %teamcity.build.id%
echo "buildid=$buildid"
buildtypeid=$3 # %system.teamcity.buildType.id%
echo "buildtypeid=$buildtypeid"
tcbranch=$4 # %teamcity.build.branch%
echo "tcbranch=$tcbranch"
phase=$5 # STARTED | FINALIZED
echo "phase=$phase"
secretmessage=$6 # %secretmessage% (when phase=FINALIZED, something (success) or nothing (failure))
echo "secretmessage=$secretmessage"

repoOwner="satellite-of-love"
repoName="carrot"
slackTeamId="T7LSAC14L" # LightningMcQueen

buildnumber=$BUILD_NUMBER
if [[ $phase == "STARTED" ]] ; then
    echo "I am just getting started"
    status=STARTED
else
    if [[ -z "$secretmessage" ]] ; then
        echo "I have no secret message so I must have failed"
        status=FAILURE
    else
        echo "The secret message is <$secretmessage>"
        status=SUCCESS
    fi
fi

echo STATUS=$status

endpoint="https://webhook.atomist.com/atomist/jenkins/teams/$slackTeamId"

giturl="https://github.com/$repoOwner/$repoName"
#giturl=$(git config --get remote.origin.url)
branch=$(git rev-parse --abbrev-ref HEAD)
echo $branch
#gitsha="c75c7670253f6f6c9894df9ad867e78435210d8e"
gitsha=$(git rev-parse HEAD)
stingygsting="http://$tcbaseurl/viewLog.html?buildId=$buildid&buildTypeId=$buildtypeid&tab=buildLog"

scm="{\"url\": \"$giturl\", \"branch\": \"$branch\", \"commit\": \"$gitsha\"}"

payload="{\"name\": \"$tcbranch\", \"duration\": 3, \"build\": {\"number\": \"$buildnumber\", \"phase\": \"$phase\", \"status\": \"$status\", \"full_url\": \"$stingygsting\", \"scm\": $scm}}"
echo $payload

curl -v -XPOST -H 'Content-Type: application/json' -d "${payload}" ${endpoint}

