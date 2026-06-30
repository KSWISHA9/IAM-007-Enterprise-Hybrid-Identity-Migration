# Soft Match

## Purpose

Soft Match allows Microsoft Entra ID to join an existing cloud-only account to an on-premises Active Directory account when identity attributes match.

## Matching Attributes

Soft Match commonly uses:

- UserPrincipalName
- mail
- primary SMTP address
- proxyAddresses

## Scenario

A cloud-only account already exists:

```text
jdoe@omniverse.com
```

An AD account is prepared with matching attributes:

```text
UPN: jdoe@omniverse.com
mail: jdoe@omniverse.com
proxyAddresses: SMTP:jdoe@omniverse.com
```

After synchronization, Microsoft Entra ID can join the objects instead of creating a duplicate.

## Validation

- Cloud account remains intact
- OnPremisesSyncEnabled becomes true
- ImmutableID is populated
- License remains assigned
- No duplicate object is created

## Lessons Learned

Soft Match is preferred when attributes are clean and aligned. It is safer than Hard Match when Microsoft Entra ID can automatically determine the correct identity relationship.
