### Update-DCU
### Update DCU client from 2.4.0 to 3.1.0
### Jarred Reid 2019

### Get DCU Variable
$DCU = Get-WmiObject -Class win32_Product | Where-Object{$_.Name -match "Dell Command | Update"}

if($DCU.version -eq "2.4.0"){
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
    $DCU3 = "\\fileserver\UserShares\Dept-IT\ServiceCatalog-Technical\_Drivers-Firmware\Dell\Dell-Command-Update_0NJ7C_WIN_3.1.0_A00.EXE"

    try{
        Copy-Item $DCU3  -Destination "C:\Temp\DCU_Setup_3_1_0.exe"
    }
    catch{
        Write-Output "A connection error occured. The file could not be downloaded."
        Write-Output "Error: " $_
        break
    }

    try{
        Write-Output "Installing DCU 3.1.0..."
        $installDCU = Start-Process "C:\Temp\DCU_Setup_3_1_0.exe" -ArgumentList "/s /f" -PassThru
        ### New technique to tell Start-Process to wait until process has ended to continue the script
        $installDCU.WaitForExit()
        
        $DCU = Get-WmiObject -Class win32_Product | Where-Object{$_.Name -match "Dell Command | Update"}
        if($DCU.version -eq "3.1.0"){
        Write-Output "Installation successful!"
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

elseif($DCU -ne "3.1.0","2.4.0"){
    Write-Output "Dell Command Update not found"
    break
}