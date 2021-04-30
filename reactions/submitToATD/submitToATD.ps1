#
# reaction parameters
# set this up as a string input with the name "file" - it's meant to be the full path to the file we want to submit to ATD
$file = "{{file}}"

# Change these to suit your environment
# recommend you set up an FTP user with:
#    read-only access to a directory of tools that can be downloaded (ie. /tools)
$ftpSite = '192.168.0.100'
$ftpUser = 'user'
$ftpPass = 'pass'
$utilityDir = '/utility'

# host and creds for your ATD
$atdHost = '192.168.0.200'
$atdUser = 'user'
$atdPass = 'pass'

#
# get unique timestamp and hostname for file output tagging
#
$tempDir = 'c:\tmp'
# [System.IO.Path]::GetTempPath()

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

$ftp='ftp://' + $ftpUser + ':' + $ftpPass + '@' + $ftpSite + $utilityDir + '/atd_submit.zip'
$atdSubmitZip = $tempDir + '\atd_submit.zip'
$atdsubmit = $tempDir + '\atd_submit\atd_submit.exe'
$notify = $tempDir + '\notify.exe'
$WebClient=New-Object System.Net.WebClient
$uri=New-Object System.uri($ftp)
$WebClient.DownloadFile($uri, $atdSubmitZip)
Unzip $atdSubmitZip $tempDir

$prm = "-i", $atdHost, "-u", $atdUser, "-p", $atdPass, "-a", "1", "-f", $file
$response = & $atdsubmit $prm | ConvertFrom-Json

$date = Get-Date -format 'FileDateTimeUniversal'
$responseFile = 'c:\atd_response_' + $date + '.json'
$notifyFile = 'c:\notify_' + $date + '.txt'
$response | ConvertTo-Json -depth 100 | out-file $responseFile

$taskId = $response.results.taskId
$md5 = $response.results.md5

$date = Get-Date
$prm = $file, $md5, $taskId, $date, ":ghost:"
$response = & $notify $prm
$response | out-file $notifyFile

#
# clean up
#
Remove-Item $atdSubmitZip