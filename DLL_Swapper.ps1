Param (
    [Parameter(Mandatory, HelpMessage = "Introduce the path where your Windows is installed, for example: C:")]
    $Path #Path variable that should be passed so the scripts knows where the root instalation is.
)

$system32Path = Test-Path "$Path\Windows\System32"
$dllSystem32Path = "$Path\Windows\System32\win32spl.dll"

If ($system32Path -eq $true) {
    Try { #Tries stopping the Spooler service, if not able to, throws an error message.
        Write-Host "Stopping Spooler service..."
        Stop-Service -Name “Spooler” #Stops Spooler service so the .dll can be swapped
        Start-Sleep -Seconds 1
    }
    Catch {
        Write-Host "Error stopping the Spooler service, try executing PowerShell as an administrator."
    }

    Write-Host 'Path successfully found, trying to swap the .dll file...' #If the Spooler service could be stopped, the script continues.

    Try { #Tries taking ownership of the win32spl.dll file, if not able to, throws an error message.
        icacls $dllSystem32Path /setowner Everyone #Sets the win32spl.dll to be administrators instead of TrustedInstaller
        takeown /f $dllSystem32Path /a #Gives ownership to the administrators group, without this, the next step doesn't work.
        icacls $dllSystem32Path /grant Everyone:F #Gives full access
        Rename-Item -Path $dllSystem32Path -NewName 'win32sploldver.dll' #Renames the original file, doesn't delete it so it can be saved or swapped back.
        Start-Sleep -Seconds 1
        #Remove-Item "$Path\Windows\System32\win32sploldver.dll" #This line can be uncommented so the "old" .dll is deleted, I DON'T RECOMMEND IT, it's safer just leaving it there hanging just in case.
        Copy-Item '.\win32spl.dll' -Destination "$Path\Windows\System32" #Copies the "new" .dll (takes whatever .dll is name like that in the script folder) to System32 replacing the old one.
        Start-Sleep -Seconds 1
        icacls $dllSystem32Path /grant Everyone:R #Reverts the Everyone full access to only Read.
    }
    Catch {
        Write-Host "Error taking ownership of the win32spl.dll or something else, try executing it again as administrator." -BackgroundColor Red
        Write-Host "$_.exception.message." -BackgroundColor Red
    }

    Write-Host ".dll swap was successful, re-enabling Spooler service..."

    Try { #Tries enabling the Spooler service, if not able to, throws an error message.
        Start-Service -Name "Spooler"
    }
    Catch {
        Write-Host "Error enabling the Spooler service, try restarting your computer or enabling the Spooler service manually."
    }
}

Else {
    Write-Host '$Path error, did you write the path correctly? Try "C:" or "D:" or whatever your Windows path is without the quotes next time.' -BackgroundColor Red
}