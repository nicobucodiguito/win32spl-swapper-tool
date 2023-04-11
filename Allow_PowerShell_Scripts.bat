ECHO "Changing PowerShell script execution policies..."
REG ADD HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell -v "ExecutionPolicy" /d "Unrestricted"
ECHO "If everything went well this should have the "Unrestricted" parameter set"
REG QUERY "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy"
PAUSE