#
# reaction parameters
# set this up as a string input with the name "filename" - it's meant to be the full path to the file we want to get
$sourceFile = "{{filename}}"

# Change these to suit your environment
# recommend you set up an FTP user with:
#    write-only access (blind dropbox/upload) to a directory for evidence collection (ie. /evidence)
$ftpSite = '192.168.0.100'
$ftpUser = 'user'
$ftpPass = 'pass'
$evidenceDir = '/evidence'

#
# get unique timestamp and hostname for file output tagging
#
$date = Get-Date -format "FileDateTimeUniversal"
$destFile = $date + '_' + $Env:Computername + '_' + $sourceFile.Replace('\', '_').Replace(':', '.')

$ftp="ftp://" + $ftpUser + ":" + $ftpPass + "@" + $ftpSite + "/" + $evidenceDir + "/" + $destFile
$WebClient=New-Object System.Net.WebClient
$uri=New-Object System.uri($ftp)
$WebClient.UploadFile($uri, $sourceFile)