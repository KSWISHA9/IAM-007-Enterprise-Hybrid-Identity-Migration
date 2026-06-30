<#
.SYNOPSIS
Calculates ImmutableID from AD ObjectGUID and optionally applies it to a cloud user using Microsoft Graph.

.EXAMPLE
.\04-Hard-Match-ImmutableID.ps1 -SamAccountName jdoe -CloudUPN jdoe@omniverse.com

.EXAMPLE
.\04-Hard-Match-ImmutableID.ps1 -SamAccountName jdoe -CloudUPN jdoe@omniverse.com -Apply
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SamAccountName,

    [Parameter(Mandatory=$true)]
    [string]$CloudUPN,

    [switch]$Apply
)

Import-Module ActiveDirectory

$adUser = Get-ADUser -Identity $SamAccountName -Properties ObjectGUID,UserPrincipalName,mail
$immutableId = [Convert]::ToBase64String($adUser.ObjectGUID.ToByteArray())

$result = [PSCustomObject]@{
    SamAccountName = $adUser.SamAccountName
    AD_UPN = $adUser.UserPrincipalName
    CloudUPN = $CloudUPN
    ObjectGUID = $adUser.ObjectGUID
    ImmutableID = $immutableId
}

$result

if ($Apply) {
    Import-Module Microsoft.Graph.Authentication
    $Body = @{ onPremisesImmutableId = $immutableId } | ConvertTo-Json
    Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/users/$CloudUPN" -Body $Body -ContentType "application/json"
    Write-Host "ImmutableID applied to $CloudUPN" -ForegroundColor Green
} else {
    Write-Host "Preview only. Re-run with -Apply after validation." -ForegroundColor Yellow
}
