# Installation
There are only two things that need to be done. They will need to be done as an administrator.

1. Trust remotely signed scripts (like `powershell_setup.ps1`)
 - run `Set-ExecutionPolicy RemoteSigned`

2. Install the fonts that can be found in ~/zsh_env/fonts (WSL file path, the Windows Explorer file path is **VERY** different)
  - run `.\install.ps1`

## The powershell_setup.ps1 script can do these things for you
* You simply need to make sure the file path is accurate (might have to change the user names) then right click the file in Windows Explorer and choose `Run with PowerShell`. You will also have to run the script as an administrator.

This is the last step of your initial WSL setup.

# If the terminal looks corrupted...
The fonts probably didn't auto-load. You will need to right click the Ubuntu logo on the terminal, select `Properties`, chose `DejaVu Sans Mono for Powerline`, and click `OK`. Restart the terminal and everything should be good to go.