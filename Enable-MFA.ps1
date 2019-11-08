<# Automatically enable MFA for user accounts

Show MFA enabled users:
Get-MsolUser  | Select-Object UserPrincipalName,StrongAuthenticationMethods,StrongAuthenticationRequirements

Show all MFA enabled users that have enrolled:
Get-MsolUser | Where-Object {$_.StrongAuthenticationMethods -like “*”}  | select UserPrincipalName,StrongAuthenticationMethods,StrongAuthenticationRequirements

Enable MFA:
Create the StrongAuthenticationRequirement object
$mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mf.RelyingParty = “*”
$mfa = @($mf)

Enable MFA for specific user:
Set-MsolUser -UserPrincipalName eshlomo@elishlomo.us -StrongAuthenticationRequirements $mfa

Create an array with disabled MFA users
Create another array with "blacklisted users"

Define if statement:
if userprincipal name exists in "blacklist", skip

elif:
Iterate through array, enabling MFA by userprincipal name
#>



function Enable-MFA {

$UPN = Read-Host -Prompt "Enter an email (UPN)"

$mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mf.RelyingParty = "*"
$mfa = @($mf)

Set-MsolUser -UserPrincipalName $UPN -StrongAuthenticationRequirements $mfa
}

Enable-MFA