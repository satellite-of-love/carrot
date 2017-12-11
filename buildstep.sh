echo hello world
echo $SHELL
git status
git remote show origin
echo 1 %system.build.number%
echo 2 %teamcity.build.id%
echo 4 $BUILD_NUMBER
echo $0
tcbaseurl=$1
endpoint="https://webhook.atomist.com/atomist/jenkins/teams/T7LSAC14L"
buildid=%teamcity.build.id%
buildtypeid=%system.teamcity.buildType.id%
echo 3 $buildtypeid
giturl="https://github.com/satellite-of-love/carrot"
#giturl=$(git config --get remote.origin.url)
branch=$(git rev-parse --abbrev-ref HEAD)
echo $branch
#gitsha="c75c7670253f6f6c9894df9ad867e78435210d8e"
gitsha=$(git rev-parse HEAD)
stingygsting="http://$tcbaseurl/viewLog.html?buildId=$buildid&buildTypeId=$buildtypeid&tab=buildResultsDiv"

scm="{\"url\": \"$giturl\", \"branch\": \"$branch\", \"commit\": \"$gitsha\"}"

payload="{\"name\": \"$buildtypeid\", \"duration\": 3, \"build\": {\"number\": \"$buildid\", \"phase\": \"STARTED\", \"status\": \"STARTED\", \"full_url\": \"$stingygsting\", \"scm\": $scm}}"
echo $payload
	
curl -v -XPOST -H 'Content-Type: application/json' -d "${payload}" ${endpoint}

