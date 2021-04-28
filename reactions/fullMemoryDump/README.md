# McAfee-MVISION-EDR-Custom Reaction fullMemoryDump

This example shows how you can use a custom reaction script to pull down and execute an arbitrary memorydump tool, or use a built in OS capability or pre-deployed tool, execute it to generate the required output (in this case a memory dump) and then upload the output to an evidence vault

Note that the windows powershell script relies on DumpIt.exe, which needs to be on an accessible FTP share (see comments in the script)

Windows: fullMemoryDump.ps1
Linux: fullMemoryDump.sh
MacOS: &lt;todo&gt;