## Assignment Title

**Just-In-Time Admin Access for a Merger: Least-Privilege Role Design + Audit-Ready Operations**

## Background & Scenario

Your company just acquired a small startup. You need to onboard a batch of new employees quickly, and a few of them must manage **enterprise applications** in Microsoft Entra ID (SSO configuration, app assignments, basic app lifecycle). Security leadership is strict: **no Global Admin by default**, and all admin access must be **time-bound and auditable** due to compliance requirements.

This assignment builds on the core idea from Lab 01: **Entra directory roles enable scoped admin tasks (least privilege), and role assignment must be managed as an operational control** (not a one-time click). ([Microsoft Learning][1])

## Objective

By the end, you will deliver a working **least-privilege admin model** for app administration that supports:

* **Bulk onboarding** of users (operational realism)
* **Just-in-time (JIT)** admin access (when possible via PIM)
* **Verification** that privileges work *only* when intended
* **Audit evidence** (who had what role, when, and why)

## Your Tasks (The Lab)

1. **Build the “Merger Wave” user set (bulk onboarding)**

* Create 8–12 new user accounts in bulk (CSV or Microsoft Graph PowerShell).
* Include attributes that matter operationally (e.g., Department = “AcquiredCo”, JobTitle, Usage Location).
* Outcome: you can filter and manage these users as a cohort, not one-by-one.

2. **Design a least-privilege admin plan (role mapping)**

* Identify which **Entra ID directory role(s)** are required to manage enterprise apps for:

  * A primary App Admin (does day-to-day app work)
  * A backup App Admin (only during incidents/coverage)
* Document why you chose those roles over broader roles (e.g., why not Global Admin).

3. **Implement time-bound admin access (PIM if available, otherwise emulate)**

* If PIM is available in your tenant: make the backup admin **Eligible**, enforce justification, and require activation for a limited duration.
* If PIM is not available: implement a “manual JIT” process where you assign the role, validate access, then remove it immediately after the task.
* Outcome: “standing privilege” is minimized.

4. **Prove the privilege boundary (negative + positive testing)**

* Test as the user **before** role assignment/activation: confirm they cannot perform the app admin action(s).
* Test again **after** assignment/activation: confirm they can.
* Finally test **after removal/expiry**: confirm access is gone.
* Capture the evidence you’d show an auditor (screenshots, timestamps, and a short explanation).

5. **Operationalize: produce an audit-ready runbook**

* Write a 1–2 page runbook (Markdown is fine) that includes:

  * Role request criteria (who qualifies)
  * Approval expectations (even if “self-approved” in lab, state what would happen in real orgs)
  * Activation/removal steps at a high level
  * Evidence checklist (what logs or records you would retain)

## Knowledge Check (Answer briefly)

1. **Why is “Application Administrator” a better choice than “Global Administrator” for this scenario, and what risk does it reduce?** ([Microsoft Learning][1])
2. **Explain the difference between “Eligible” vs “Active” role assignment (PIM) and how that changes your attack surface.** ([Microsoft Learning][1])
3. **If you had to do this at scale, why is Graph/PowerShell-based onboarding and role management operationally safer than portal-only clicks?** (Think: consistency, audit trails, repeatability, error rate.)

## Hint (If needed)

* Search Microsoft docs for **“Microsoft Entra built-in roles”** and **“Privileged Identity Management (PIM) for Entra roles”**.
* For automation, look up **Microsoft Graph PowerShell** cmdlets around user creation and role assignment (the lab itself already nudges you toward Graph tooling). ([Microsoft Learning][1])

[1]: https://microsoftlearning.github.io/SC-300-Identity-and-Access-Administrator/Instructions/Labs/Lab_01_ManageUserRoles.html
