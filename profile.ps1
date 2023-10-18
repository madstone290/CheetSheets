# This file should be at C:\Users\{UserName}\Documents\WindowsPowerShell\profile.ps1
function ex {
	param (
        [string]$Path = "."
    )
	
    Start-process explorer $Path
}
