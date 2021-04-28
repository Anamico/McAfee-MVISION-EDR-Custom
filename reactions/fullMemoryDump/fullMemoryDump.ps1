# Change these to suit your environment
# recommend you set up an FTP user with:
#    read-only access to a directory of tools that can be downloaded (ie. /tools)
#    write-only access (blind dropbox/upload) to a directory for evidence collection (ie. /evidence)
$ftpSite = '192.168.0.100'
$ftpUser = 'user'
$ftpPass = 'pass'
$utilityDir = '/utility'
$evidenceDir = '/evidence'

#
# get unique timestamp and hostname for file output tagging
#
$date = Get-Date -format "FileDateTimeUniversal"
$tempDir = 'c:\'
$tempFile = $Env:Computername + '_' + $date + '_MemoryDump'

#
# pull down the memory dump tool
#
$ftp="ftp://" + $ftpUser + ":" + $ftpPass + "@" + $ftpSite + $utilityDir + "/DumpIt.exe.zip"
$dumpitZip = $tempDir + 'DumpIt.exe.zip'
$WebClient=New-Object System.Net.WebClient
$uri=New-Object System.uri($ftp)
$WebClient.DownloadFile($uri, $dumpitZip)
Expand-Archive -LiteralPath $dumpitZip -DestinationPath $tempDir

#
# get a memory dump (may take a while)
#
$env:Path = $env:Path + ';' + $tempDir
$dumpLocation = $tempDir + $tempFile
DumpIt.exe /O $dumpLocation /N /Q

#
# upload the memory dump (may take a while)
#
$ftpTemplate = 'open FTPSITE
FTPUSER
FTPPASS
cd EVIDENCEDIR
lcd "TEMPDIR"
bin
hash
put "FILENAME"
bye'
$CommandFile = 'c:\ftpcommands'
$ftpCommands = $ftpTemplate.Replace('FTPSITE', $ftpSite).Replace('FTPUSER', $ftpUser).Replace('FTPPASS', $ftpPass).Replace('EVIDENCEDIR', $evidenceDir).Replace('TEMPDIR', $tempDir).Replace('FILENAME', $tempFile)
$ftpCommands | Out-File $CommandFile
Start-Process -FilePath "c:\windows\system32\ftp.exe" -ArgumentList "-s:$CommandFile" -WindowStyle Hidden

#
# clean up
#
Remove-Item $dumpitZip
Remove-Item $tempDir + "DumpIt.exe"
Remove-Item $tempFile