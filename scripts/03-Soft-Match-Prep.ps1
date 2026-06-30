<#
.SYNOPSIS
Prepares AD attributes for Soft Match.

.DESCRIPTION
Sets UPN, mail, and primary SMTP proxyAddress consistently for a user.
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$SamAccountName,

    [Parameter(Mandatory=$true)]
    [string]$TargetUPN
)

Import-Module ActiveDirectory

Set-ADUser -Identity $SamAccountName -UserPrincipalName $TargetUPN -EmailAddress $TargetUPN

$user = Get-ADUser -Identity $SamAccountName -Properties proxyAddresses

if ($user.proxyAddresses -notcontains "SMTP:$TargetUPN") {
    Set-ADUser -Identity $SamAccountName -Add @{proxyAddresses = "SMTP:$TargetUPN"}
}

Get-ADUser -Identity $SamAccountName -Properties UserPrincipalName,mail,proxyAddresses |
Select-Object Name,SamAccountName,UserPrincipalName,mail,proxyAddresses
