# McAfee-MVISION-EDR-Custom Reaction submitToATD

This example shows how you can use a custom reaction script to pull down and execute an arbitrary executable tool, or use a built in OS capability or pre-deployed tool, and execute it to submit a named file to McAfee ATD

NOTE: This relies on a zip file on an accessible resources share (ftp site - see code comments for the target platform).
The zip file needs to contain 2 executables. The first is the atd_submit.py exe, the second is the notify example exe.

&lt;more notes to go here&gt;
Windows: submitToATD.ps1
Linux: submitToATD.sh
MacOS: <&lt;todo&gt;

## Important reminder for security

EDR Reactions execute on the endpoint. If you are running a script that requires authentication to achieve something, it will be resident on the endpoint for a period of time. It goes to follow that therefore any credentials could be stolen.

Seriously look at whatever scripts you are sending and the privileges required on any external systems, and assume that you are basically publishing the username and password to give anyone access.

So in this case, you would only perhaps use an atd user with the ability to submit samples via REST only. That is about what most users can do anyway.