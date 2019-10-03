### Windows 10 1809 Wallpaper Fix Script v2.0.1

### Changelog:
### Version 1.0.0 - Initial Release
### Version 2.0.0 - Integrated ICACLS to set permissions instead of GetACL/SetACL
### Version 2.0.1 - Fixed ICACLS parameters to set permissions to child objects

### Set wpPath variable to default wallpaper path
$wpPath = "C:\Windows\Web\Wallpaper\Windows"

### Set wpPathOld variable to old wallpaper path
$wpPathOld = "C:\Windows.old\windows\Web\Wallpaper\Windows"

### Gives ownership of the default wallpaper path to ADMINISTRATORS group
takeown /F $wpPath /R /A

### Gives ownership of the old wallpaper path to ADMINISTRATORS group
takeown /F $wpPathOld /R /A

### Gives full control of WP folder to ADMINISTRATORS group
icacls "C:\Windows\Web\Wallpaper\Windows" /grant "ADMINISTRATORS:F" /T

### Gives full control of old WP folder to ADMINISTRATORS group
icacls "C:\Windows.old\windows\Web\Wallpaper\Windows" /grant "ADMINISTRATORS:F" /T

### Overwrite default Windows "img0.jpg" file with Keystone Industries picture (WITH FORCE!)
Copy-Item "C:\Windows.old\windows\Web\Wallpaper\Windows\img0.jpg" -Destination "C:\Windows\Web\Wallpaper\Windows\img0.jpg" -force
