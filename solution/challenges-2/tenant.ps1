$tenantID = ""
$clientID = ""
$clientSecret = ""

$secureSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force

$credentials = New-Object System.Management.Automation.PSCredential($clientId, $secureSecret)

Connect-MgGraph -ClientSecretCredential $credentials -TenantId $tenantID 

# https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.identity.directorymanagement/get-mgorganization?view=graph-powershell-1.0

$org = Get-MgOrganization

[PSCustomObject]@{
    OrganizationName = $org.DisplayName
    TenantID = $org.Id
    DomainList = $org.VerifiedDomains
    Contact = $org.TechnicalNotificationMails
    Country = $org.CountryLetterCode
    PrivacyProfile = $org.PrivacyProfile
} | ConvertTo-Json | Out-File "org.json" -Encoding utf8