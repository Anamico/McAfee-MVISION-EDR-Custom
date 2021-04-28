#$file = "{{file}}"
$tempDir = 'c:\'
# [System.IO.Path]::GetTempPath()

$ftp='ftp://mcafee:mcafee@13.211.141.129/notify.zip'
$notifyZip = $tempDir + 'notify.zip'
$notify = $tempDir + 'notify.exe'
$WebClient=New-Object System.Net.WebClient
$uri=New-Object System.uri($ftp)
$WebClient.DownloadFile($uri, $notifyZip)

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Unzip $notifyZip $tempDir
#Expand-Archive -LiteralPath $atdSubmitZip -DestinationPath $tempDir
#Remove-Item $dumpitZip
$prm = "-i", "10.1.1.22", "-u", "admin", "-p", "McAfee123!", "-a", "1", "--f", $file
$response = & $notify 
#$prm

$date = Get-Date -format 'FileDateTimeUniversal'
$responseFile = 'c:\notify_' + $date + '.json'
$response | out-file $responseFile
