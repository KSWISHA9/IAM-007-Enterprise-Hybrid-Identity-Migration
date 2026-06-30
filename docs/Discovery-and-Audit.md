# Discovery and Audit

## Purpose

Discovery is the first phase of an enterprise identity migration. Before changing any user objects, the IAM team must understand the current identity state across Active Directory and Microsoft Entra ID.

## Business Scenario

OmniVerse Enterprises acquired another organization with existing Microsoft 365 cloud-only accounts. The IAM team must determine which accounts are cloud-only, which are synchronized, which require Soft Match, and which require Hard Match.

## Data Collected

- SamAccountName
- DisplayName
- UserPrincipalName
- mail
- proxyAddresses
- ObjectGUID
- ImmutableID
- OnPremisesSyncEnabled
- AccountEnabled
- License state
- Duplicate UPNs
- Duplicate proxyAddresses

## Classification Buckets

| Bucket | Description |
|---|---|
| Already Synced | Cloud account is already linked to AD |
| Cloud-only | Cloud account exists without on-premises sync |
| Needs Soft Match | Attributes can be aligned for automatic matching |
| Needs Hard Match | ImmutableID must be assigned manually |
| Needs Fresh Provision | No cloud account exists |
| Excluded | Service, admin, disabled, or test accounts |

## Lessons Learned

A migration should never begin with bulk changes. Discovery reduces risk by identifying duplicate objects, stale accounts, and unsafe migration candidates before production changes occur.
