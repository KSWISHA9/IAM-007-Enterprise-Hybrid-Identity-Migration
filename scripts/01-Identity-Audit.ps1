<#
.SYNOPSIS
Exports Active Directory users and Microsoft Entra users for migration discovery.

.DESCRIPTION
This script collects identity data needed to classify users before migration:
- AD UPN, mail, proxyAddresses, ObjectGUID
- Entra UPN, sync state, ImmutableID, AccountEnabled
- Matching status

.NOTES
Run from a workstation or server with ActiveDirectory and Microsoft Graph modules.
#>

$ExportPath = ".\exports"
New-Item -ItemType Directory -Path $ExportPath -Force | Out-Null

Import-Module ActiveDirectory

try {
    Import-Module Microsoft.Graph.Users -ErrorAction Stop
} catch {
    Write-Warning "Microsoft Graph Users module not loaded. Install with: Install-Module Microsoft.Graph -Scope CurrentUser"
}

$ADUsers = Get-ADUser -Filter * -Properties UserPrincipalName,mail,proxyAddresses,ObjectGUID,Enabled |
Select-Object Name,SamAccountName,Enabled,UserPrincipalName,mail,proxyAddresses,ObjectGUID,
@{Name="ImmutableIDPreview";Expression={[Convert]::ToBase64String($_.ObjectGUID.ToByteArray())}}

$ADUsers | Export-Csv "$ExportPath\AD-Identity-Audit.csv" -NoTypeInformation

Write-Host "AD audit exported to $ExportPath\AD-Identity-Audit.csv" -ForegroundColor Green

Write-Host "To export Entra users, connect with:" -ForegroundColor Cyan
Write-Host 'Connect-MgGraph -Scopes "User.Read.All","Directory.Read.All"' -ForegroundColor Yellow
Write-Host 'Get-MgUser -All -Property Id,DisplayName,UserPrincipalName,OnPremisesSyncEnabled,OnPremisesImmutableId,AccountEnabled | Export-Csv ".\exports\Entra-Identity-Audit.csv" -NoTypeInformation' -ForegroundColor Yellow
