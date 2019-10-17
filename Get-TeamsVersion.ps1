### This will get the currently installed version of Teams on a give machine
### The Teams version registry key can only be accessed by the currently logged on user. 

### The only reason the script will fail is if a user is not logged in, so set all errors to terminating to allow catch statement to work.
$ErrorActionPreference = "STOP"
$pc = hostname

try{
### Get the currently user by finding the active owner of the explorer.exe process
$cu = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').GetOwner().User

### Pass $cu variable into the system object 
$user = New-Object System.Security.Principal.NTAccount($cu)

### Generate SID using system object
$sid = $user.Translate([System.Security.Principal.SecurityIdentifier]).value

### Mount CURRENT USER hive, do not print the output
New-PSDrive HKU Registry HKEY_USERS | Out-Null
### Append $sid varible into registry path and get current Teams Version
$teamsversion = Get-ItemProperty HKU:\$sid\Software\Microsoft\Windows\CurrentVersion\Uninstall\Teams | Select DisplayVersion -expand DisplayVersion

Write-Output $pc" - "$teamsversion
}

catch{
    
    Write-Output $PC" - N/A"
}