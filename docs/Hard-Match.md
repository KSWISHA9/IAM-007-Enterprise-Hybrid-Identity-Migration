# Hard Match

## Purpose

Hard Match manually links an on-premises AD user to an existing Microsoft Entra ID cloud account by assigning the correct ImmutableID.

## When Hard Match Is Needed

Hard Match may be required when:

- Soft Match fails
- A duplicate synced object already exists
- The cloud account has no ImmutableID
- The production cloud mailbox must be preserved
- The synced duplicate owns the current source anchor

## Workflow

1. Confirm production cloud account exists
2. Confirm duplicate synced object exists
3. Convert AD ObjectGUID to Base64 ImmutableID
4. Remove or deprovision conflicting duplicate
5. Purge duplicate if required
6. Assign ImmutableID to production cloud account
7. Return AD object to sync scope
8. Run Delta Sync
9. Validate final state

## Safety Checks

- Never purge a duplicate until the production cloud account is confirmed live
- Never assign ImmutableID until the AD object and cloud user are verified
- Always log before and after states

## Lessons Learned

Hard Match is powerful but risky. It should be performed with strict validation, logging, and rollback awareness.
