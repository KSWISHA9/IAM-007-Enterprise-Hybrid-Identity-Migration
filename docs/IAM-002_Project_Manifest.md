# IAM-002 Enterprise Identity Migration Toolkit - Project Manifest

## Scripts

-   01-Identity-Audit.ps1
-   02-UPN-Migration.ps1
-   03-Soft-Match-Prep.ps1
-   03-HardMatch.ps1
-   03-HardMatch-Batch-Final.ps1
-   04-Hard-Match-ImmutableID.ps1
-   05-Batch-Migration.ps1
-   06-Validation.ps1
-   07-Rollback.ps1

## Reports / Exports

-   IAM002-AD-Audit.csv
-   IAM002-Discovery-Audit.csv
-   IAM002-Discovery-Summary.csv
-   IAM002-Discovery-Summary.txt
-   IAM002-Entra-Audit.csv
-   IAM002-HardMatch-Final-Log.csv
-   IAM002-HardMatch-Log.csv
-   IAM002-Migration-Plan.csv
-   IAM002-Migration-Summary.csv
-   IAM002-Pilot-Fix-Disabled-CloudOnly.csv
-   IAM002-PostMigration-Validation.csv
-   IAM002-PreFlight-Report.csv
-   IAM002-Rollback-Log.csv

## Documentation

-   Discovery-and-Audit.md
-   UPN-Migration.md
-   Soft-Match.md
-   Hard-Match.md
-   Hard-Match-Workflow.md
-   ImmutableID.md
-   Validation.md
-   Rollback-Plan.md
-   Migration-Runbook.md
-   Troubleshooting-Guide.md
-   Lessons-Learned.md
-   Two-Object-Pattern.md

## Diagrams

-   Identity-Migration-Flow.md
-   Two-Object-Pattern.md

## Suggested Screenshot Names

-   01-Identity-Audit.png
-   02-UPN-Migration.png
-   03-Soft-Match-Preparation.png
-   04-Hard-Match-ImmutableID.png
-   05-PreFlight-Health-Check.png
-   06-Hard-Match-Batch-Execution.png
-   07-Hard-Match-Batch-Summary.png
-   08-Post-Migration-Validation.png
-   09-Rollback-Validation.png

## Final Results

-   40 pilot users
-   40/40 validation PASS
-   Rollback validation PASS
-   ImmutableID matched
-   Sync enabled
-   Account enabled

## Next Project

IAM-003 -- Enterprise Application Integration - SAML - OIDC - OAuth -
Enterprise Applications - App Registrations - SCIM Provisioning - Claims
Mapping - RBAC - Group Assignment - Application Onboarding - Testing -
Troubleshooting
