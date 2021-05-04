# McAfee-MVISION-EDR-Custom
Examples of custom collector and reaction scripts

## Important reminder for security

EDR Collectors execute on the endpoint. If you are running a script that requires authentication to achieve something, it will be resident on the endpoint for a period of time. It goes to follow that therefore any credentials could be stolen.

Seriously look at whatever scripts you are sending and the privileges required on any external systems, and assume that you are basically publishing the username and password to give anyone access.
