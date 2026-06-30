<#
.SYNOPSIS
Batch migration framework with safety checks and CSV logging.

.DESCRIPTION
This script is a controlled framework for batch hard match or migration operations.
It intentionally requires a CSV input and includes stop-on-failure behavior.
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$CsvPath
)

if (!(Test-Path $CsvPath)) {
    throw "CSV not found: $CsvPath"
}

$LogPath = ".\exports\Batch-Migration-Log.csv"
$Rows = Import-Csv $CsvPath
$Results = @()

foreach ($row in $Rows) {
    try {
        if ([string]::IsNullOrWhiteSpace($row.SamAccountName) -or [string]::IsNullOrWhiteSpace($row.CloudUPN)) {
            throw "Missing SamAccountName or CloudUPN"
        }

        $Results += [PSCustomObject]@{
            Timestamp = Get-Date
            SamAccountName = $row.SamAccountName
            CloudUPN = $row.CloudUPN
            Status = "READY"
            Message = "Passed input validation"
        }
    } catch {
        $Results += [PSCustomObject]@{
            Timestamp = Get-Date
            SamAccountName = $row.SamAccountName
            CloudUPN = $row.CloudUPN
            Status = "FAILED"
            Message = $_.Exception.Message
        }

        $Results | Export-Csv $LogPath -NoTypeInformation
        throw "Safety check failed. Batch stopped."
    }
}

$Results | Export-Csv $LogPath -NoTypeInformation
Write-Host "Batch validation complete. Log: $LogPath" -ForegroundColor Green
