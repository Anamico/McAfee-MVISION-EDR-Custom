#!/bin/bash

# this example is based on CENTOS

# Change these to suit your environment
# recommend you set up an FTP user with:
#    read-only access to a directory of tools that can be downloaded (ie. /tools)
#    write-only access (blind dropbox/upload) to a directory for evidence collection (ie. /evidence)
ftpSite='192.168.0.100'
ftpUser='user'
ftpPass='pass'
evidenceDir='/evidence'

date=`date -u "+%Y%m%dT%H%M%S000Z"`
# make sure no spaces or special characters in the tmpdir path
tempDir='/tmp'
hostname=`hostname`
tempFile="${hostname}_${date}_MemoryDump"

dd if=/dev/mem of="${tempDir}/${tempFile}"
ftp "${tempDir}/${tempFile}" "${ftpuser}:${ftppass}@${ftpSite}${evidenceDir}"

#
# cleanup
#
rm "${tempDir}/${tempFile}"