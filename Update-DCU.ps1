<# Update-DCU
Update DCU client from 2.4.0 to 3.1.0
Jarred Reid - 2019

Changelog:
1.0.0 - Initial release
1.0.1 - Fixed a bug where users would be notified about updates
#>


### Get DCU Variable
$DCU = Get-WmiObject -Class win32_Product | Where-Object {$_.Name -match "Dell Command | Update"}

if($DCU.version -eq "2.4.0" -or "3.0.1"){

<# 
    Write-Output "Older version found. Beginning uninstall process..."
    try{
        $DCU.Uninstall()
    }
    catch{
        Write-Output "An error occured during the uninstall process. Please try again."
        Write-Output "Error: " $_
        break
        
    }
 #>
    Write-Output "Older version found. Downloading DCU 3.1.0."
    $DCU3 = "\\fileserver\UserShares\Dept-IT\ServiceCatalog-Technical\_Drivers-Firmware\Dell\Dell_Command_Update\Dell-Command-Update_0NJ7C_WIN_3.1.0_A00.EXE"
    $DCUSettings = "\\fileserver\UserShares\Dept-IT\ServiceCatalog-Technical\_Drivers-Firmware\Dell\Dell_Command_Update\DCU-Settings.xml"

    try{
        Copy-Item $DCU3 -Destination "C:\Temp\DCU_Setup_3_1_0.exe"
        Copy-Item $DCUSettings -Destination "C:\Temp\DCU-Settings.xml"
    
    }
    catch{
        Write-Output "A connection error occured. The file could not be downloaded."
        Write-Output "Error: " $_
        break
    }

    try{
        Write-Output "Installing DCU 3.1.0..."

        $installDCU = Start-Process "C:\Temp\DCU_Setup_3_1_0.exe" -ArgumentList "/s /f" -PassThru
        ### New technique to tell Start-Process to wait until process has ended to continue the script:
        $installDCU.WaitForExit()
        
        ### Check if DCU.version matches string "3.1.0" before printing success message
        $DCU = Get-WmiObject -Class win32_Product | Where-Object{$_.Name -match "Dell Command | Update"}
        if($DCU.version -eq "3.1.0"){
        Write-Output "Installation successful!"
        
        ### Import settings from XML file
        Start-Process "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" -ArgumentList "/configure -importSettings=C:\Temp\DCU-Settings.xml"
        Write-Output "Settings imported."

        ### Clean up, clean up, everybody do your share. Leaving XML file because the settings won't import successfully until the next launch of DCU
        Remove-Item "C:\Temp\DCU_Setup_3_1_0.exe"

        break
        }
    }
    catch{
        Write-Output "An error occurred while installing."
        Write-Output "Error: " $_
        break
    }

}

if($DCU.Version -eq "3.1.0"){
    Write-Output "Latest version installed."
    break
}

elseif($DCU -ne "3.1.0" -or "2.4.0" -or "3.0.1"){
    Write-Output "Dell Command Update not installed."
    break
}
