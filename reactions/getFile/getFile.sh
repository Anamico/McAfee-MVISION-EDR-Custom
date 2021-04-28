#!/bin/bash

#
# reaction parameters
# set this up as a string input with the name "filename" - it's meant to be the full path to the file we want to get
sourceFile="{{filename}}"
destFileName=`echo "${sourceFile}" | sed "s/:/./g" | sed "s/\//_/g"`
echo $destFileName > /test.out

# Change these to suit your environment
# recommend you set up an FTP user with:
#    write-only access (blind dropbox/upload) to a directory for evidence collection (ie. /evidence)
ftpSite='192.168.0.100'
ftpUser='user'
ftpPass='pass'
evidenceDir='/evidence'

#
# get unique timestamp and hostname for file output tagging
#
date=`date -u "+%Y%m%dT%H%M%S000Z"`
hostname=`hostname`
destFile="${date}_${hostname}_${destFileName}'

ftp "$sourceFile" "ftp://${ftpUser}:${ftpPass}@"${ftpSite}${evidenceDir}/$destFile