# Validation

## Purpose

Validation proves that migration completed successfully without breaking access or creating duplicate identities.

## Validation Checklist

- Cloud account exists
- AccountEnabled is true
- OnPremisesSyncEnabled is true
- ImmutableID is populated
- UPN is correct
- mail attribute is correct
- proxyAddresses are correct
- Licenses are preserved
- Duplicate objects are removed
- Delta Sync completed successfully

## Lessons Learned

Migration is not complete when a script finishes. Migration is complete only after identity state, access, and synchronization are validated.
