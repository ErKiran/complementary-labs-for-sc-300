**Federate Vendor Access with Google Sign-In + Guardrails (B2B Collaboration)**

## Background & Scenario

Our company is onboarding a new vendor, **SummitOps**, for a 90-day engagement. Their workforce uses **Google Workspace**, and they refuse to create Microsoft accounts. The business wants fast access to one internal app (**“Vendor Support Portal”**) *without* weakening our external-access posture. Your job is to enable **Google-federated sign-in for B2B guests**, while adding the controls we’d expect to justify during an audit (who can invite, what domains are allowed, what access is granted, and what evidence is logged).

This builds on the lab’s core idea: inviting B2B guests and letting them sign in using a Google identity provider. 

## Objective

By the end, you will have:

1. Google configured as a federated identity provider for B2B collaboration,
2. External access constrained to approved vendor domains,
3. A controlled onboarding path (invitation + scoped access), and
4. Audit-ready evidence via sign-in/audit logs.

## Your Tasks (The Lab)

1. **Federate Google as an identity provider (workforce tenant B2B)**

   * Configure Google federation in Entra External Identities using a Google OAuth client (client ID/secret + redirect URIs).
   * Capture *what you configured* (client ID, secret handling approach, redirect URIs) and *why those redirect URIs matter* for trust boundaries.

2. **Add “vendor guardrails” before inviting anyone**

   * Configure External Collaboration settings to **allow only SummitOps’ email domain(s)** for invitations (block everything else), and ensure guest access is appropriately restricted for your scenario. (Think “we’re collaborating with a vendor,” not “we’re adding employees.”)

3. **Implement a controlled invitation model (who can invite)**

   * Create a security group like **Vendor-Inviters** and restrict guest invitations to only that group (not all users).
   * Explain the operational reason (prevent uncontrolled external sprawl) and the audit reason (provable control over external onboarding). ([Microsoft Learn][2])

4. **Scope the vendor’s access (don’t just “let them in”)**

   * Grant access to **only one target resource** (the “Vendor Support Portal” enterprise app, a test app, or an access package if you’re using governance features).
   * Ensure access is **time-bounded** (expiration) and can be reviewed/removed cleanly at contract end.

5. **Validate sign-in + collect evidence (audit-ready)**

   * Complete an end-to-end test: invite a test SummitOps user, redeem invitation, and sign in using Google federation (verify the experience differs from non-federated flows).
   * Pull evidence from **Sign-in logs** and **Audit logs** showing (a) IdP configuration changes and (b) the external user sign-in event. ([Microsoft Learn][3])

## Knowledge Check (For you to answer in a brief summary)

1. **Federation vs. “just inviting a guest”:** What security and user-experience difference do you get when Google federation is configured correctly (especially around extra verification / redemption flow)?
2. **Control plane question:** Why is “allowing Google as an IdP” *not* sufficient by itself—what specific risks remain if you don’t restrict domains and who can invite? ([Microsoft Learn][2])
3. **Policy behavior:** If you apply Conditional Access to guests, what are the main gotchas for external users, and how would you justify your policy choice (MFA requirement, device signals, sign-in frequency) for a vendor workforce? ([Microsoft Learn][4])

## Hint (If needed)

* Microsoft doc on **Google federation for External Identities** (workforce/B2B): ([Microsoft Learn][5])
* Microsoft doc on **Conditional Access for external users** (important considerations): ([Microsoft Learn][4])
* Microsoft doc on **external collaboration settings** and **B2B sign-in logs**: ([Microsoft Learn][3])

If you want, I can also give you a **submission checklist** (screenshots + log fields to capture + a 1-page “design rationale” template) so your write-up looks like real IAM engineer evidence.
