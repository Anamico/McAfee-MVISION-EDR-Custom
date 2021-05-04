# McAfee-MVISION-EDR-Custom Reaction fullMemoryDump

This example shows how you can use a custom reaction script to pull down and execute an arbitrary memorydump tool, or use a built in OS capability or pre-deployed tool, execute it to generate the required output (in this case a memory dump) and then upload the output to an evidence vault

Note that the windows powershell script relies on DumpIt.exe, which needs to be on an accessible FTP share (see comments in the script)

Windows: fullMemoryDump.ps1
Linux: fullMemoryDump.sh
MacOS: &lt;todo&gt;

Note also that the linux version currently depends on fmem being installed, but you could use a different tool, or even push it out as part of the script as our testing did not require a reboot.

## Important reminder for security

EDR Reactions execute on the endpoint. If you are running a script that requires authentication to achieve something, it will be resident on the endpoint for a period of time. It goes to follow that therefore any credentials could be stolen.

Seriously look at whatever scripts you are sending and the privileges required on any external systems, and assume that you are basically publishing the username and password to give anyone access.

That is why it is recommended to use only a public read for utility download and a public write (no read) directory for uploads. Then the utility of having access to the ftp site is limited.