### Print-CafeMenu - Jarred Reid 2019
### This program will automatically print the Cafe Menu to IT_Printer3 (c). It checks and stores the current hash info of the menu, and executes the script once the hash changes.
### Version 1.0

$menuPDF = "C:\Users\jreid\Keystone Industries\Keystone Industries Intranet - Documents\GT- Cafe Menus\Mimi's Cafe Menu.pdf"
$currentmenuhash = Get-FileHash $menuPDF | select -expand Hash
$storedhashFile = "C:\Temp\hash.txt"
$storedhash = Get-Content $storedhashFile

if($currentmenuhash -ne $storedhash){
    Write-Output "Hash Not match, printing menu"
    Set-Content $storedhashFile $currentmenuhash
    Start-Process -FilePath $menuPDF -Verb Print -PassThru | %{sleep 10;$_} | kill
}

elseif($currentmenuhash -eq $storedhash){
    Write-Output "Hash matches. Not printing menu"
}