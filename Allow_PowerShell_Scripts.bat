ECHO "Changing PowerShell script execution policies..."
:: Modifies the value "ExecutionPolicy" and sets it to "Unrestricted" thus allowing PowerShell scripts execution on the computer.
REG ADD HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell -v "ExecutionPolicy" /d "Unrestricted"
ECHO "If everything went well ExecutionPolicy should have the "Unrestricted" parameter set"
:: Checks whether the value was correctly modified
REG QUERY "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy"
PAUSE