# UPN Migration

## Purpose

UPN migration standardizes user sign-in names before cloud synchronization and identity matching.

## Scenario

Legacy users may have a UPN suffix such as:

```text
user@legacy.omniverse.local
```

The target cloud-ready suffix is:

```text
user@omniverse.com
```

## Migration Workflow

1. Export current UPN values
2. Validate target suffix
3. Update AD UserPrincipalName
4. Update mail attribute if required
5. Preserve proxyAddresses
6. Run Delta Sync
7. Validate Microsoft Entra ID

## Risk

UPN changes affect sign-in behavior and should be piloted before bulk migration.

## Lessons Learned

UPN migration is not only a technical change. It affects user sign-in, application access, communication, and support readiness.
