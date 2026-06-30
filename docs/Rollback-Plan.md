# Rollback Plan

## Purpose

Rollback planning defines how the IAM team responds if a migration step creates an unexpected issue.

## Rollback Options

- Restore original UPN
- Restore original mail attribute
- Restore original proxyAddresses
- Move AD object back to previous OU
- Stop further batch processing
- Review Graph logs
- Review Entra Connect export errors
- Restore deleted cloud object if still recoverable

## Safety Rule

Never continue batch migration after a failed safety check.

## Lessons Learned

A migration plan without a rollback plan is incomplete. Rollback planning protects user access, mailboxes, licenses, and operational continuity.
