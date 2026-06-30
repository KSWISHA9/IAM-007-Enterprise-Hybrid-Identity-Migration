# Hybrid Identity Migration Engineering (IAM-002)

> OmniVerse Enterprise Engineering Portfolio

## Overview

This project documents an enterprise identity migration and synchronization operations scenario involving cloud-only Microsoft Entra ID accounts, synchronized Active Directory identities, UPN migration, Soft Match, Hard Match, ImmutableID, Microsoft Graph automation, safety checks, validation, and rollback planning.

IAM-002 builds directly on IAM-001 by using the hybrid identity platform established with Microsoft Entra Connect.

## Business Scenario

OmniVerse Enterprises recently acquired another organization that already had Microsoft 365 cloud-only accounts created before identity synchronization was standardized.

The migration objective was to merge existing cloud-only identities with synchronized Active Directory identities without losing mailboxes, licenses, Teams data, OneDrive data, or creating duplicate accounts.

## Environment

| Component | Value |
|---|---|
| Source Directory | Active Directory |
| Cloud Directory | Microsoft Entra ID |
| Sync Platform | Microsoft Entra Connect |
| Automation | PowerShell + Microsoft Graph |
| Migration Type | Cloud-only to hybrid identity |
| Matching Methods | Soft Match and Hard Match |
| Key Attribute | ImmutableID / Source Anchor |
| Validation | Graph, Entra, AD, CSV reports |

## Architecture

```text
Active Directory User
        |
        | ObjectGUID / UPN / proxyAddresses
        v
Microsoft Entra Connect
        |
        | Sync / Join / Export
        v
Microsoft Entra ID User
        |
        | License / Mailbox / Teams / OneDrive
        v
Validated Hybrid Identity
```

## Migration Strategy

The migration followed a controlled phased approach:

1. Discover all AD and Microsoft Entra identities
2. Classify users into migration buckets
3. Identify cloud-only accounts
4. Detect duplicate synchronized objects
5. Prepare UPN, mail, and proxyAddresses
6. Perform Soft Match when possible
7. Perform Hard Match when Soft Match fails
8. Validate ImmutableID and sync state
9. Confirm licenses and account state
10. Log every action to CSV

## Phase 1 — Discovery and Identity Audit

Discovery identifies all Active Directory and Microsoft Entra users and classifies each account by synchronization state, UPN, mail, proxyAddresses, license state, and ImmutableID.

## Phase 2 — UPN Migration

UPNs are standardized from a legacy suffix to the target enterprise suffix before synchronization or matching.

## Phase 3 — Soft Match

Soft Match is attempted when the on-premises AD account and the cloud account share matching UPN, mail, or SMTP/proxyAddresses values.

## Phase 4 — Hard Match

Hard Match is used when Soft Match cannot safely join the objects. The AD user's ObjectGUID is converted to a Base64 ImmutableID value and assigned to the correct cloud identity using Microsoft Graph.

## Phase 5 — Batch Automation

After manual pilot validation, the workflow is scaled to batches using safety checks and CSV-driven automation.

## Phase 6 — Validation

Final validation confirms:

- Cloud account still exists
- ImmutableID is assigned
- OnPremisesSyncEnabled is true
- AccountEnabled is true
- Licenses are preserved
- Duplicate objects are removed
- No unexpected errors occurred

## PowerShell Automation

| Script | Purpose |
|---|---|
| `01-Identity-Audit.ps1` | Exports AD and Entra identity data for migration planning |
| `02-UPN-Migration.ps1` | Performs controlled UPN updates from legacy to target suffix |
| `03-Soft-Match-Prep.ps1` | Prepares attributes required for Soft Match |
| `04-Hard-Match-ImmutableID.ps1` | Converts ObjectGUID to ImmutableID and applies it with Graph |
| `05-Batch-Migration.ps1` | Batch migration framework with safety checks and CSV logging |
| `06-Validation.ps1` | Validates final migrated identity state |
| `07-Rollback.ps1` | Documents rollback support actions |

## Troubleshooting Scenarios

This project covers common hybrid identity migration issues:

- Cloud-only accounts
- Duplicate synchronized objects
- Duplicate UPN
- Duplicate proxyAddresses
- Missing mail attribute
- Incorrect ImmutableID
- Soft Match failure
- Hard Match requirement
- Recycle bin duplicate cleanup
- Sync export validation

## Skills Demonstrated

- Microsoft Entra ID
- Active Directory
- Microsoft Entra Connect
- Microsoft Graph PowerShell
- Soft Match
- Hard Match
- ImmutableID
- ObjectGUID conversion
- UPN migration
- Duplicate attribute troubleshooting
- Batch automation
- CSV logging
- Safety checks
- Rollback planning
- Enterprise identity migration documentation

## Project Outcome

This project demonstrates how to plan and execute an enterprise identity migration from cloud-only Microsoft 365 accounts into a synchronized hybrid identity model while preserving access, licensing, mailbox continuity, and user data.

## Future Enhancements

- Automated test harness
- Advanced Graph reporting
- License preservation report
- Teams and OneDrive validation
- ServiceNow migration change record
- Sentinel monitoring for identity migration events

## Created By

Keshawn Lynch
