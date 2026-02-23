$tenantID = "id"
$clientID = "cid"
$clientSecret="csc"

$secureSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force

$credentials = New-Object System.Management.Automation.PSCredential($clientId, $secureSecret)

Connect-MgGraph -ClientSecretCredential $credentials -TenantId $tenantID 

$PWProfile = @{
    Password                      = "itrytoHit@@@6iex!"
    ForceChangePasswordNextSignIn = $false
}

# Documentation: https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/new-mguser?view=graph-powershell-1.0

$user = New-MgUser `
    -DisplayName "Glen Maxwell" `
    -GivenName "Glen" -Surname "Maxwell" `
    -MailNickname "Maxi" `
    -UsageLocation "AUS" `
    -UserPrincipalName "g.maxwell@ca.onmicrosoft.com" `
    -PasswordProfile $PWProfile -AccountEnabled `
    -Department "Cricket" `
    -JobTitle "Allrounder" `

$managerPrincipalName = "r.pointing@ca.onmicrosoft.com"

$manager = Get-MgUser -Filter "userPrincipalName eq '$managerPrincipalName'" -Property Id

$manager.Id

# https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/set-mgusermanagerbyref?view=graph-powershell-1.0
Set-MgUserManagerByRef -UserId $user.Id -BodyParameter @{
    "@odata.id" = "https://graph.microsoft.com/v1.0/users/$($manager.Id)"
}

# OData = Open Data Protocol, microsoft graph api is based on top of OData conventions
# https://www.odata.org/getting-started/basic-tutorial/

Get-MgUserManager -UserId $user.Id | Select-Object Id, DisplayName, UserPrincipalName