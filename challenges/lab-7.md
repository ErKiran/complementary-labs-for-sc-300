## Assignment Title

**MFA Rollout Under Audit Pressure: Conditional Access + Phishing-Resistant MFA (Without Locking Everyone Out)**

## Background & Scenario

Your company just failed an internal access-control audit: too many accounts can access Microsoft 365 and a sensitive internal app using only a password. Leadership wants an MFA rollout **this week**, but operations is worried about **user friction, emergency access lockouts, and contractors (guests)**. Your job is to design a **phased, supportable MFA enforcement** approach using **Conditional Access** (not legacy per-user MFA), and produce evidence that it works.

This builds directly on the lab’s core idea: enforcing MFA via Conditional Access and understanding where legacy per-user MFA fits (and why it’s generally not the recommended long-term control).

## Objective

By the end, you will have:

* A **pilot MFA policy** for a defined group of users.
* A **stronger (phishing-resistant) MFA requirement** for privileged/admin access.
* A clean **exception strategy** (break-glass) and a **validation method** (What If + sign-in logs).
* A short written **rollout + troubleshooting note** you could hand to a real IAM team.

## Your Tasks (The Lab)

1. **Design your rollout groups (and exclusions)**

   * Create or identify:

     * `MFA-Pilot-Users` (small set)
     * `Privileged-Users` (admins / elevated roles)
     * `BreakGlass-Accounts` (1–2 emergency access accounts)
   * Document *why* break-glass accounts must be excluded from some Conditional Access policies (and how you’ll secure them differently).

2. **Enable modern MFA enforcement strategy (avoid legacy traps)**

   * Confirm you are enforcing MFA through **Conditional Access**, not only “per-user MFA” states.
   * Record what can go wrong operationally if someone enables **per-user MFA** for a user who is also targeted by Conditional Access (think: precedence, troubleshooting confusion, inconsistent prompts).

3. **Create two Conditional Access policies (start safe)**

   * **Policy A: “MFA Pilot – Microsoft 365”**

     * Target: `MFA-Pilot-Users`
     * Cloud app: Microsoft 365 (or your test enterprise app)
     * Grant: Require MFA
     * Start in **Report-only**, then move to **On** after validation.
   * **Policy B: “Admin Access – Phishing-Resistant MFA”**

     * Target: `Privileged-Users`
     * Target resources: admin portals / high-impact apps you choose
     * Grant: require **phishing-resistant MFA** (via Authentication Strengths)
     * Exclude: `BreakGlass-Accounts` 

4. **Validate like an engineer (not like a clicker)**

   * Use the **Conditional Access What If tool** to simulate:

     * Pilot user accessing M365
     * Privileged user accessing an admin resource
     * Break-glass user scenario (ensure it behaves as intended)
   * Confirm outcomes in **sign-in logs** and note what evidence you’d export for an audit (policy result, applied controls, authentication requirement). ([Microsoft Learn][4])

5. **Write a 1-page operational handoff**

   * Include:

     * Rollout sequence (pilot → expand → enforce)
     * User impact (what prompts they’ll see)
     * Backout plan (what you disable first if things break)
     * The top 3 troubleshooting checks (logs, What If, exclusions)

## Knowledge Check (For you to answer in a brief summary)

1. **Why is Conditional Access the preferred control plane for MFA vs “per-user MFA”?** Give two operational reasons (not just “it’s recommended”). 
2. **What makes “phishing-resistant MFA” different from basic MFA?** Name at least one attack it’s designed to reduce and how the “authentication strength” concept helps enforce that. 
3. In your validation, you see a user wasn’t prompted for MFA. List **three** likely causes you would check **in order**, and specify which tool/log proves each cause (What If vs sign-in logs vs policy config). 

## Hint (If needed)

* **Authentication Strengths overview (MFA / passwordless / phishing-resistant):** 
* **Phishing-resistant MFA Conditional Access policy guidance:** 
* **What If tool for simulating policy evaluation:** 
* **Conditional Access troubleshooting with sign-in logs:** 

If you want to really push this to “market-ready”: add a short section in your handoff called **“Avoid Lockout Patterns”** and include the break-glass rationale + how you’d monitor for policy drift.