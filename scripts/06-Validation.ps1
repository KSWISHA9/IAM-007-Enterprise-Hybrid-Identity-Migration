<#
.SYNOPSIS
Validates final Microsoft Entra user state after migration.

.EXAMPLE
.\06-Validation.ps1 -CloudUPN jdoe@omniverse.com
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$CloudUPN
)

Import-Module Microsoft.Graph.Users

Get-MgUser -UserId $CloudUPN -Property Id,DisplayName,UserPrincipalName,OnPremisesSyncEnabled,OnPremisesImmutableId,AccountEnabled |
Select-Object DisplayName,UserPrincipalName,AccountEnabled,OnPremisesSyncEnabled,OnPremisesImmutableId
