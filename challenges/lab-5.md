## Assignment Title

**Secure Vendor Onboarding in Entra ID: Guest Invitations, Bulk Operations, and Automation-Ready Runbook**

## Background & Scenario

Contoso just signed a 60-day contract with a vendor (Fabrikam) to help with a time-sensitive project. You need to onboard **25 external vendor users** quickly, but Security added two requirements after a recent audit finding: (1) the onboarding must be **repeatable and least-privilege**, and (2) you must produce **audit-ready evidence** showing who was invited, how, and what access they received. This assignment builds on the core guest invitation workflows (single invite, bulk invite, and Graph/PowerShell invitation). 

## Objective

By the end, you will deliver a **mini “Vendor Guest Onboarding” runbook** that:

* Onboards vendor users using **three methods** (single, bulk, and PowerShell/Graph). 
* Ensures guests land in a **controlled access boundary** (a dedicated group you manage).
* Includes **verification steps + evidence** suitable for an internal audit.

## Your Tasks (The Lab)

1. **Design the onboarding control plane (least privilege + scope).**

   * Decide which Entra role(s) should be allowed to invite guests (aim for least privilege, not Global Admin). The lab mentions Guest Inviter as a valid approach. 
   * Document the minimum Graph permission you’d request for an invitation script (hint: it’s not always `User.ReadWrite.All`). 

2. **Create an access boundary for vendors.**

   * Create a security group named something like `Vendors-Project-Atlas`.
   * Your runbook must state the rule: “All vendor guests must be placed in this group before receiving any app access.”

3. **Onboard guests using three invitation methods (and keep it consistent).**

   * Invite **1 guest** using the Entra admin center “Invite external user” flow. 
   * Invite **20 guests** using **Bulk invite (CSV)**, ensuring you include the required fields (email + redirect URL). 
   * Invite **4 guests** using **Microsoft Graph PowerShell** (`New-MgInvitation`). 
   * Operational constraint: avoid group email addresses and avoid “plus addressing” in emails (it can break delivery). 

4. **Prove the guest objects are created correctly (verification + evidence).**

   * Verify that invited accounts show **User type = Guest** in the directory. 
   * Capture evidence of: (a) the guest users list, (b) bulk operation results, and (c) PowerShell output showing invites were created.

5. **Access assignment + validation (keep it minimal, but real).**

   * Grant access to *something* only via the `Vendors-Project-Atlas` group (e.g., assign that group to an Enterprise App, or document how you would).
   * Validate that an invited user who redeems the invite can reach the intended landing page (redirect URL behavior is part of the invite design). 

**Deliverable (what you submit):**

* A 1–2 page runbook (markdown is fine) with: invitation methods used, least-privilege choices, verification checklist, and screenshots/outputs as evidence.

## Knowledge Check (Answer in a brief summary)

1. **What exactly gets created in Entra the moment you send an invitation—before the user accepts it—and why does that matter for audits and cleanup?** (Think: directory object existence vs. “access actually used.”) 

2. **Why is the “redirect URL” a security-relevant setting, not just a convenience setting?** Describe one misuse scenario and how you’d prevent it. 

3. **Least privilege reasoning:** For PowerShell/Graph invitations, compare `User.Invite.All` vs `User.ReadWrite.All`. Why is one safer, and when might you still need the broader one? 

## Hint (If needed)

* Review Microsoft’s guest invitation quickstart to understand the **invite + redemption flow** and expected behavior. 
* For automation, read the permissions section for `New-MgInvitation` / the Graph invitation API to pick the **least privileged** scope. 