# McAfee-MVISION-EDR-Custom Reaction getFile

This example shows how you can use a custom reaction script to retrieve an arbitrary file on a remote host and upload it to an ftp site

Windows: getFile.ps1
Linux: &lt;todo&gt;
MacOS: &lt;todo&gt;

## Important reminder for security

EDR Reactions execute on the endpoint. If you are running a script that requires authentication to achieve something, it will be resident on the endpoint for a period of time. It goes to follow that therefore any credentials could be stolen.

Seriously look at whatever scripts you are sending and the privileges required on any external systems, and assume that you are basically publishing the username and password to give anyone access.

That is why it is recommended to use only a public read for utility download and a public write (no read) directory for uploads. Then the utility of having access to the ftp site is limited.