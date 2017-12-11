

tcbaseurl=$1
buildid=$2 # %teamcity.build.id%
buildtypeid=$3 # %system.teamcity.buildType.id%
phase=$4

echo hello world
echo $SHELL
git status
git remote show origin
echo 2 $buildid
echo 4 $BUILD_NUMBER
echo $0
endpoint="https://webhook.atomist.com/atomist/jenkins/teams/T7LSAC14L"

echo 3 $buildtypeid
giturl="https://github.com/satellite-of-love/carrot"
#giturl=$(git config --get remote.origin.url)
branch=$(git rev-parse --abbrev-ref HEAD)
echo $branch
#gitsha="c75c7670253f6f6c9894df9ad867e78435210d8e"
gitsha=$(git rev-parse HEAD)
stingygsting="http://$tcbaseurl/viewLog.html?buildId=$buildid&buildTypeId=$buildtypeid&tab=buildResultsDiv"

scm="{\"url\": \"$giturl\", \"branch\": \"$branch\", \"commit\": \"$gitsha\"}"

payload="{\"name\": \"$buildtypeid $buildid\", \"duration\": 3, \"build\": {\"number\": \"$BUILD_NUMBER\", \"phase\": \"$phase\", \"status\": \"$phase\", \"full_url\": \"$stingygsting\", \"scm\": $scm}}"
echo $payload

curl -v -XPOST -H 'Content-Type: application/json' -d "${payload}" ${endpoint}

