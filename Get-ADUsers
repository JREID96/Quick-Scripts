<# Active Directory Master User List v1.0.0 - Jarred Reid 2019
This script will use information pulled from Active Directory to compile a full list of employees, their alias, manager, and their department.
Changelog:
1.0.0 - Initial Release
#>

### Accesses Active Directory OUs to pull the list of users. The "Manager" property is made into a calculated property to remove excess parts.
function Get-CHUsers {
    $CHList = Get-ADUser -filter * -SearchBase "OU=Site1,OU=End Users (Azure AD Sync),OU=_USERS (Secure) - Windows 10 Image,DC=DC01,DC=com" -Properties * | select -Property Name, SamAccountName, Department, @{N="Manager";expression = {$_.Manager.split(",")[0] -replace 'CN='}} | sort Department, Name
}

function Get-GTUsers{
    $GTList = Get-ADUser -filter * -SearchBase "OU=Site2,OU=End Users (Azure AD Sync),OU=_USERS (Secure) - Windows 10 Image,DC=DC01,DC=com" -Properties * | select -Property Name, SamAccountName, Department, @{N="Manager";expression = {$_.Manager.split(",")[0] -replace 'CN='}} | sort Department, Name
}

function Get-MTUsers{
    $MTList = Get-ADUser -filter * -SearchBase "OU=Site3,OU=End Users (Azure AD Sync),OU=_USERS (Secure) - Windows 10 Image,DC=DC01,DC=com" -Properties * | select -Property Name, SamAccountName, Department, @{N="Manager";expression = {$_.Manager.split(",")[0] -replace 'CN='}} | sort Department, Name
}

Get-CHUsers
Get-GTUsers
Get-MTUsers
