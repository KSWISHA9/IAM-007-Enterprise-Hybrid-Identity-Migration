<#
.SYNOPSIS
Rollback support helper for identity migration.

.DESCRIPTION
This script documents rollback actions and can be expanded with environment-specific restore logic.
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SamAccountName,

    [Parameter(Mandatory=$true)]
    [string]$OriginalUPN
)

Import-Module ActiveDirectory

Write-Host "Rollback plan for $SamAccountName" -ForegroundColor Cyan
Write-Host "1. Restore original UPN: $OriginalUPN"
Write-Host "2. Review mail and proxyAddresses"
Write-Host "3. Run Delta Sync"
Write-Host "4. Validate Microsoft Entra state"

Set-ADUser -Identity $SamAccountName -UserPrincipalName $OriginalUPN

Get-ADUser -Identity $SamAccountName -Properties UserPrincipalName,mail,proxyAddresses |
Select-Object Name,SamAccountName,UserPrincipalName,mail,proxyAddresses
