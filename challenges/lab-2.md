## Assignment Title

**Tenant Identity Baseline: Namespace, Ownership Contacts, and Privacy Signals (Audit-Ready)**

## Background & Scenario

Contoso is onboarding two new partner firms (vendors) and spinning up a new “Sales” business unit. Security leadership also scheduled a light compliance audit next week. Before you can safely scale guest collaboration or automate anything (Graph/PowerShell), the tenant’s **identity “foundation” metadata** must be correct: domains/subdomains for naming, clear technical/privacy ownership for incident response, and a privacy statement that external guests can see during consent/review flows. This assignment extends the SC-300 tenant properties lab into a realistic operational baseline. 

## Objective

By the end, you will have:

* A **clean tenant namespace strategy** (subdomain(s) created and documented). 
* Correct **tenant properties** (display name, technical contact), plus **privacy contact + privacy statement URL** configured. 
* An **evidence pack + short runbook** suitable for an internal audit request.
* A **programmatic export** (Graph/PowerShell) proving you can retrieve the same tenant properties without relying on portal clicks.

## Your Tasks (The Lab)

1. **Design and implement a tenant namespace plan (subdomains)**

   * Create **two** functional subdomains under your `.onmicrosoft.com` tenant (example pattern: `sales.<tenant>.onmicrosoft.com`, `vendors.<tenant>.onmicrosoft.com`).
   * Document what each subdomain is for (UPN naming, partner separation, future custom domain mapping). 

2. **Set “ownership” metadata: tenant display name + technical contact**

   * Update the tenant display name to reflect a realistic org name (ex: “Contoso – Identity Lab”).
   * Set the **technical contact** to a real admin identity you control (or a dedicated break-glass monitored mailbox *in a real org*).
   * Capture evidence (screenshot + timestamp). 


3. **Operationalize it: export tenant properties via Graph/PowerShell**

   * Use Microsoft Graph (or Graph PowerShell) to export: organization display name, technical contact (if exposed), privacy contact/statement (where available), tenant ID, and domain list.
   * Store the export in a small “tenant-baseline” file (JSON or CSV) and include it in your evidence pack as the “automation proof.”

## Knowledge Check (For you to answer in a brief summary)

1. **Tenant naming vs domains:** What’s the difference between the **tenant display name** and the **tenant’s domain/UPN namespace**? In what real scenarios would you change one but not the other? 
2. **Immutability and compliance:** Why is tenant **Country/Region** treated as non-changeable in practice, and how does that connect to **data residency** and long-term compliance commitments? 
3. **Tenant ID in the real world:** Where does Tenant ID show up operationally (example: token claims, multi-tenant routing, subscription trust), and why is it dangerous to treat `tid` alone as a sufficient trust boundary without validating issuer/tenant context? 

