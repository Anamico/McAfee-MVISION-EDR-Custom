#!/bin/bash

# reaction parameters
# set this up as a string input with the name "file" - it's meant to be the full path to the file we want to submit to ATD
file="{{file}}"

# Change these to suit your environment
# recommend you set up an FTP user with:
#    read-only access to a directory of tools that can be downloaded (ie. /tools)
ftpSite='192.168.0.100'
ftpUser='user'
ftpPass='pass'
utilityDir='/utility'

# host and creds for your ATD
atdHost='192.168.0.200'
atdUser='user'
atdPass='pass'
analyzerProfile='1'

#
# get unique timestamp and hostname for file output tagging
#
tempDir='/tmp'

cd $tempDir
ftp -in $ftpSite << SCRIPTEND
user $ftpUser $ftpPass
binary
cd $utilityDir
get atd_submit.tgz
exit
SCRIPTEND

tar -xvzf atd_submit.tgz
chmod 700 atd_submit
date=`date -u "+%Y%m%dT%H%M%S000Z"`
responseFile="/tmp/atd_response_${date}.json"

./atd_submit -i $atdHost -u "$atdUser" -p "$atdPass" -a $analyzerProfile -f $file > $responseFile

# $taskId = $response.results.taskId
# $md5 = $response.results.md5

# $date = Get-Date
# $prm = $file, $md5, $taskId, $date, ":ghost:"
# $response = & $notify $prm
# $response | out-file $notifyFile

#
# clean up
#
rm /tmp/atd_submit.tgz
rm /tmp/atd_submit