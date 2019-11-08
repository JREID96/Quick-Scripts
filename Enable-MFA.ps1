function Enable-MFA {

$UPN = Read-Host -Prompt "Enter an email (UPN)"

$mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mf.RelyingParty = "*"
$mfa = @($mf)

Set-MsolUser -UserPrincipalName $UPN -StrongAuthenticationRequirements $mfa
}

Enable-MFA
