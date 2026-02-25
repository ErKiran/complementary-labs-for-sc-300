## Introduction

This task is a general configuration tasks and depends on the UI functionality. As the cloud is agile and UI changes often. I would documents the steps for my future references and as a pointer to someone reading it. 

## Task-1

**Design and implement a tenant namespace plan (subdomains)**

1. In the Microsoft Entra ID, search for the Domain Name in the search bar.

    ![domain_name](evidences/domain_name.png)

2. Then, add a custom domain name. You can use a any domain name that you own or prove. You need to configure the TXT record and MX records provided by the Entra to prove that you are the owner of the domain you provided. 

    Note: *Entra doesn't allow any .onmicrosoft.com domains as a custom domain.*

    The custom domains added for sales and vendors subdomains

    ![redacted](evidences/redacted_domains.png)

**Document what each subdomain is for (UPN naming, partner separation, future custom domain mapping).**

1. **sales.contoso.com**: 
    
    **Purpose:** Dedicated namespace for new sales business unit.

    **UserPrincipleName(UPN) Naming:**

     * Use this for sales user's UPNs to make identities instantly recognizable.

     * Pattern can be firstname.lastname@sales.contoso.com 

     * Clean identity scoping for searches, reporting, and admin operations.


    **Partner Separation**: Clear distinction from vendor/guest identities. It help avoid "mixed identity" issues.

2. **vendor.contoso.com**: 
    
    **Purpose:** Namespace for partner/vendor collaboration and clear seperation from the internal staff identities.

    **UserPrincipleName(UPN) Naming:**

     * For B2B guests, vendors keep their home identity (e.g. user@vendor.com) and appear as guest.

     * If and only if they need internal identities, pattern can be `vendorname-contact@vendors.contoso.com` 


    **Partner Separation**: Clear distinction from internal staffs.  It help avoid "mixed identity" issues.

## Task-2 

**Set “ownership” metadata: tenant display name + technical contact**

Tenants metadata can be updated via a Properties menu in a overview page. 

![tenant-property](evidences/tenant-properties.png)

## Task-3

**Operationalize it: export tenant properties via Graph/PowerShell** 

The automation script [tenant](tenant.ps1)

JSON as a proof [Org](org.json)

****Tenant naming vs domains:** What’s the difference between the **tenant display name** and the **tenant’s domain/UPN namespace**? In what real scenarios would you change one but not the other?**

Tenant Display name is for company branding. Changing the Tenant Name doesn't change identity login or DNS 

Tenant's Domain/UPN is the identity namespace used in the identity login and is tied to DNS the company owned. Changing/adding this affects how users authenticate and how identities are represented across Microsoft services.

When Display Name changes but not UPN 

* Rebranding of the company while keeping the same UPN 
* Merger and Acquistion

When UPN Namespace changes but not domain name

* You add/verify a new domain and migrate UPNs (@contoso.onmicrosoft.com → @contoso.com) while keeping the same org display name.

* You need guest collaboration/policy consistency under the same tenant name, but users must authenticate with a newly acquired domain

**Why is tenant **Country/Region** treated as non-changeable in practice, and how does that connect to **data residency** and long-term compliance commitments?**

https://docs.azure.cn/en-us/entra/fundamentals/data-residency

A tenant is mapped to a Geo-Location when it's created and is immutiable due to compliance and regulations for Data Residency [Data at rest]. The tenant’s country/region also influences billing, tax, and service availability.

Furthermore, for long-term compliance commitments a immutiable country provides

* Audit trails and attestations (“Where has identity directory data lived historically?”)

* Regulatory mappings (GDPR/UK GDPR, sector regs, public sector rules, etc.)

* Operational guarantees about where core identity metadata is stored and processed by default 

****Tenant ID in the real world:** Where does Tenant ID show up operationally (example: token claims, multi-tenant routing, subscription trust), and why is it dangerous to treat `tid` alone as a sufficient trust boundary without validating issuer/tenant context?**

Tenant ID shows up in the token claims as `tid` and `iss`, it's also used for multi-tenant routing. Azure subscriptions are associated to a directory/tenant. This is why RBAC principals, service principals, managed identities, etc. are fundamentally scoped to a directory context.

JWT must be validated by the signature. Because JWT are open standard and anyone can tweak the JWT to increase scope or impersonate so JWT validation through signature is most. Furthermore, `iss` and `aud` validations provided more contextual security.