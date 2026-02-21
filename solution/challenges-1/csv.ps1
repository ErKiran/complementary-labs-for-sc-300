$tenantID = "id"
$clientID = "cid"
$clientSecret="csc"

$domain = "mydomain"

$appName = "myapp"

$secureSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force

$credentials = New-Object System.Management.Automation.PSCredential($clientId, $secureSecret)

Connect-MgGraph -ClientSecretCredential $credentials -TenantId $tenantID 

$csvPath = "challenge-1.csv"

# Read csv file as a normal text file -> Skip the first objection (version 1.0) -> convert to CSV file
$users = Get-Content $csvPath | Select-Object -Skip 1 | ConvertFrom-Csv

# @{
#    n = "newPropertyName"
#    e = { expression to calculate the value }
# }
# Use a new header instead of messy one

$clean = $users | Select-Object `
@{n = "displayName"; e = { $_.'Name [displayName] Required' } },
@{n = "userPrincipalName"; e = { $_.'User principal name [userPrincipalName] Required' } },
@{n = "password"; e = { $_.'Initial password [passwordProfile] Required' } },
@{n = "accountEnabled"; e = { if ($_.'Block sign in (Yes/No) [accountEnabled] Required' -eq 'Yes') { $false } else { $true } } },
@{n = "givenName"; e = { $_.'First name [givenName]' } },
@{n = "surname"; e = { $_.'Last name [surname]' } },
@{n = "jobTitle"; e = { $_.'Job title [jobTitle]' } },
@{n = "department"; e = { $_.'Department [department]' } },
@{n = "usageLocation"; e = { $_.'Usage location [usageLocation]' } },
@{n = "manager"; e = { ($_.'Manager') } }


foreach ($row in $clean) {
    $PWProfile = @{
        Password                      = $row.password
        ForceChangePasswordNextSignIn = $false
    }

    $upn = $row.userPrincipalName
    $nick = ($upn.Split('@')[0]) -replace '[^a-zA-Z0-9._-]', ''   
    $nick = $nick.Trim('.', '-', '_')                              
    $nick = $nick.Substring(0, [Math]::Min(64, $nick.Length))     

    $user = New-MgUser `
        -DisplayName $row.displayName `
        -GivenName $row.givenName -Surname $row.surname `
        -UsageLocation $row.usageLocation `
        -MailNickname $nick `
        -UserPrincipalName $row.userPrincipalName.Replace("acquiredco", $domain) `
        -PasswordProfile $PWProfile -AccountEnabled `
        -Department $row.department `
        -JobTitle $row.jobTitle `

    if (-not [string]::IsNullOrWhiteSpace($row.manager)) {
        $manager = $row.manager.Replace("parentorg", $domain)
        $mgr = Get-MgUser -Filter "userPrincipalName eq '$manager'" -Property Id
        Set-MgUserManagerByRef -UserId $user.Id -BodyParameter @{
            "@odata.id" = "https://graph.microsoft.com/v1.0/users/$($mgr.Id)"
        }
    }    
}
