param(
    [Parameter(Mandatory=$true, HelpMessage="Enter a UPN/alias")]
    [String]$UPN
    )
    
    $mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $mf.RelyingParty = "*"
    $mfa = @($mf)
    
    $mf.State = "Enforced"
    
    Set-MsolUser -UserPrincipalName $UPN -StrongAuthenticationRequirements $mfa
    