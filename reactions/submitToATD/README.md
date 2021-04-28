# McAfee-MVISION-EDR-Custom Reaction submitToATD

This example shows how you can use a custom reaction script to pull down and execute an arbitrary executable tool, or use a built in OS capability or pre-deployed tool, and execute it to submit a named file to McAfee ATD

NOTE: This relies on a zip file on an accessible resources share (ftp site - see code comments for the target platform).
The zip file needs to contain 2 executables. The first is the atd_submit.py exe, the second is the notify example exe.

&lt;more notes to go here&gt;
Windows: submitToATD.ps1
Linux: submitToATD.sh
MacOS: <&lt;todo&gt;