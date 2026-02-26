$tenantID = "tID"
$clientID = "cID"
$clientSecret="cSC"

$secureSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force

$credentials = New-Object System.Management.Automation.PSCredential($clientId, $secureSecret)

Connect-MgGraph -ClientSecretCredential $credentials -TenantId $tenantID 

$csvPath = "inviteee.csv"

# Read csv file as a normal text file -> Skip the first objection (version 1.0) -> convert to CSV file
$users = Get-Content $csvPath | Select-Object -Skip 1 | ConvertFrom-Csv

$clean = $users | Select-Object `
@{n = "name"; e = { $_.'Name of invitee [inviteeName]' } },
@{n = "email"; e = { $_.'Email address to invite [inviteeEmail] Required' } },
@{n = "redirectURL"; e = { $_.'Redirection url [inviteRedirectURL] Required' } },
@{n = "sendEmail"; e = { $_.'Send invitation message (true or false) [sendEmail]' } }


foreach ($row in $clean) { 

    # https://learn.microsoft.com/en-us/entra/external-id/b2b-quickstart-invite-powershell
    $invitedUser = New-MgInvitation `
       -InvitedUserDisplayName $row.name `
       -InvitedUserEmailAddress $row.email `
       -InviteRedirectUrl $row.redirectURL `
       -SendInvitationMessage: ([System.Convert]::ToBoolean($row.sendEmail)) `

    Write-Host $invitedUser.Status
}
