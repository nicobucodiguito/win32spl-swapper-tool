# Win32Spl.dll swapper for the Shared Printers not working problem

## Info
---


Simple utility written in PowerShell to "solve" the problem of network shared printers not working or not connecting in Windows 10.

This "problem" seems to be caused by a security patch (it may be KB5006670, it may also be KB5005652, or KB5005613, or even KB5005565, I don't really know the original patch that caused this) for Windows 10 released somewhere in 2021. Patches were meant to fix the **PrintNightmare** vulnerabilities that put your printer and the network it was connected to in risk.

This script's purpose is to fix this problem by reverting the _win32spl.dll_ (Windows Spooler Dll) to one before all these updates were released. 
It is meant as an **extreme** solution since reverting this .dll could make your printer and PC or network **vulnerable** _again_.  The problem is that many places don't have another alternative other than sharing printers, either due to economical means, infrastructure problems or something else, so this is offered as a solution in those cases. 

- Please note that there could be other fixes, more simple ones that just require changing a value on the registry or removing security patches, look around in the internet and you may find a simpler solution, but since none of those seemed to work for my case and this was the only thing that worked _every_ time, this tool was made.

  **Remember: You can always check the scripts by yourself to see what they do.**  

## How to use
---

- **(Optional)** First execute **Allow_PowerShell_Scripts.bat** as an Adminstrator. This first script allows the system to run PowerShell scripts without all security warnings that stop scripts from running. The script is super simple, and is not _really_ necessary, you _could_ open your PowerShell and do the same with the **Set-ExecutionPolicy** to modify this manually, but this is made more for personal usage since I don't really want to do this manually every time and achieves the exact same thing as modifying it by hand.

- Then, from a PowerShell console opened as an Administrator, navigate to the folder that contains the script and execute run _".\DLL_Swapper.ps1"_ without the quotes to get started.

- You will be asked to introduce the root of your Windows folder, for default, most systems have it on C:, but just in case you have it somewhere else, you'll have to be introduce it manually.  
 **Introduce your path in the console as "C:" without the quotes, replacing "C" by the letter your Windows is in.**

- If everything goes well, the rest of the script _should_ execute without intervention.   
Once the script is done, the printer service should be up and running again and the .dll _should_ be the replaced one. In case something goes wrong, your old .dll file should be in your \System32 folder with the name "win32sploldver.dll", you can save this or leave it there just in case you need it.  
**By default the script doesn't delete the "old" win32spl.dll.**

## Additional information regarding security
---

- If able to, **check the script by yourself, don't trust random scripts in the internet.** 

- If you **don't** trust the win32spl.dll that is included in here, _that's totally okay and it is a good security practice_, you can always replace the one I included with one you trust or know that works.  As long as it is named "win32spl.dll" the script should work as intended.

## Some articles about this issue 
---
- [Fix network printing or keep Windows secure? | TheRegister](https://www.theregister.com/2021/09/21/microsoft_printnightmare/)  
- [The Windows Print nightmare continues for the enterprise | ComputerWorld](https://www.computerworld.com/article/3630629/windows-print-nightmare-continues-enterprise.html)
- [New Windows 10 KB5006670 update breaks network printing | BleepingCoputer](https://www.bleepingcomputer.com/news/microsoft/new-windows-10-kb5006670-update-breaks-network-printing/)
