# ImmutableID

## Purpose

ImmutableID is the Microsoft Entra ID cloud-side value that links a cloud account to an on-premises AD object.

## ObjectGUID Conversion

In many environments, the AD ObjectGUID is converted to Base64 and used as the ImmutableID.

```powershell
$user = Get-ADUser jdoe -Properties ObjectGUID
[Convert]::ToBase64String($user.ObjectGUID.ToByteArray())
```

## Validation

The ImmutableID assigned to the cloud account should match the Base64-converted ObjectGUID of the intended AD user.

## Lessons Learned

Incorrect ImmutableID assignment can link the wrong cloud account to the wrong AD object. Validation before assignment is mandatory.
