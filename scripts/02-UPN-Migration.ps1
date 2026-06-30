<#
.SYNOPSIS
Performs a controlled UPN migration from one suffix to another.

.EXAMPLE
.\02-UPN-Migration.ps1 -OldSuffix "legacy.com" -NewSuffix "omniverse.com" -WhatIf
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$OldSuffix,

    [Parameter(Mandatory=$true)]
    [string]$NewSuffix,

    [switch]$Apply
)

Import-Module ActiveDirectory

$ExportPath = ".\exports"
New-Item -ItemType Directory -Path $ExportPath -Force | Out-Null

$Users = Get-ADUser -Filter * -Properties UserPrincipalName,mail |
Where-Object { $_.UserPrincipalName -like "*@$OldSuffix" }

$Plan = foreach ($u in $Users) {
    $prefix = $u.UserPrincipalName.Split("@")[0]
    [PSCustomObject]@{
        SamAccountName = $u.SamAccountName
        Name = $u.Name
        OldUPN = $u.UserPrincipalName
        NewUPN = "$prefix@$NewSuffix"
    }
}

$Plan | Export-Csv "$ExportPath\UPN-Migration-Plan.csv" -NoTypeInformation

if ($Apply) {
    foreach ($item in $Plan) {
        Set-ADUser -Identity $item.SamAccountName -UserPrincipalName $item.NewUPN
        Write-Host "Updated $($item.SamAccountName): $($item.OldUPN) -> $($item.NewUPN)" -ForegroundColor Green
    }
} else {
    Write-Host "Plan only. Review exports\UPN-Migration-Plan.csv. Re-run with -Apply to execute." -ForegroundColor Yellow
}
