### This script fixes the issue where Teams does not install the program on a per user basis

$teamsvalue = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run'
$checkvalue = Get-ItemProperty -path $teamsvalue
$pcname = hostname

if ($checkvalue -match "TeamsMachineInstaller"){
    write-host "TeamsMachineInstaller found on $pcname"
}

elseif ($checkvalue -NotMatch "TeamsMachineInstallers"){
    New-ItemProperty -path $teamsvalue TeamsMachineInstaller -PropertyType ExpandString -value "%ProgramFiles%\Teams Installer\Teams.exe --checkInstall --source=default"
}
