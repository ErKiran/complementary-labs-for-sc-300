### Assignment Title

**Hybrid Identity Modernization Lab: From AD DS to Entra Cloud Sync, Seamless SSO, and AD FS Retirement**

### Background & Scenario

Your company, **Northbridge Parts**, is a mid-sized manufacturer moving from a mostly on-premises identity model to a modern hybrid identity design. Today, identity starts in on-premises AD DS, and leadership wants users to access Microsoft 365 and other cloud apps with a consistent sign-in experience. The legacy team also still relies on AD FS for a small number of federated use cases, but the long-term goal is to reduce infrastructure complexity, modernize authentication, and improve operational visibility. The reference lab’s core principle is **hybrid identity integration between on-premises Active Directory and Microsoft Entra ID**, centered on synchronizing identities and choosing the right cloud authentication model. ([microsoftlearning.github.io][1])

### Objective

By the end of this lab, you should be able to build a small hybrid identity environment from scratch, synchronize identities first with **Microsoft Entra Connect Sync** and then evaluate and transition to **Microsoft Entra Cloud Sync**, test **Password Hash Synchronization (PHS)** and **Pass-through Authentication (PTA)**, implement **Seamless SSO**, understand the Kerberos dependency behind that user experience, stand up a basic **AD FS** scenario, and then plan and execute a controlled move away from AD FS toward Microsoft Entra-based authentication. You should also validate how **Microsoft Entra Connect Health** helps monitor sync and hybrid identity components. ([Microsoft Learn][2])

### Timebox

* Build on-prem foundation: **2.5 hours**
* Join client and validate AD sign-in: **1 hour**
* Implement Entra Connect Sync and verify objects: **1.5 hours**
* Test PHS, PTA, and sign-in behavior: **1 hour**
* Implement Seamless SSO and document Kerberos flow: **1 hour**
* Compare Connect Sync vs Cloud Sync and pilot Cloud Sync: **1 hour**
* Transition selected scope to Cloud Sync and validate: **1 hour**
* Build a minimal AD FS use case: **1.25 hours**
* Phase out AD FS and document migration reasoning: **0.75 hour**
* Review monitoring with Entra Connect Health and write summary: **1 hour**

**Target total: 12 hours**

### Prerequisites / Starting Environment

Assume the following starting resources:

* One **Windows Server** VM for the Domain Controller
* One **Windows 11** VM or equivalent client
* One Microsoft Entra test tenant with permissions to configure hybrid identity
* Internet connectivity from both systems
* A test domain name such as `corp.northbridge.local`
* 5–10 test users and a few groups/OUs you will create yourself
* Optional extra server capacity if you want to isolate AD FS from the DC, though a reduced lab footprint is acceptable for learning
* A notebook or document to capture architecture decisions, test results, and failure observations

### Your Tasks (The Lab)

1. **Build the AD DS foundation**
   Deploy a Windows Server, promote it to a domain controller, and create a simple OU and group structure that reflects business units and admin boundaries. Create a small set of users with realistic naming and role patterns. As you do this, document which system is the **source of authority** for each identity attribute at this stage.

2. **Join a client and validate domain authentication**
   Join a Windows 11 client to the domain and sign in with a domain user. Validate that the user receives a normal domain logon experience. Explain what role Kerberos plays here, what the domain controller is doing during authentication, and why this matters before you introduce Microsoft Entra.

3. **Implement Microsoft Entra Connect Sync**
   Integrate the on-prem AD forest with Microsoft Entra ID using **Microsoft Entra Connect Sync**. Scope synchronization so only a selected OU or set of test objects syncs. Verify that users and groups appear correctly in Entra ID, and check whether important attributes such as UPN and display name align with your intended cloud sign-in model. The goal here is to understand traditional hybrid sync architecture and on-premises sync server dependencies. ([microsoftlearning.github.io][1])

4. **Test authentication choices with PHS and PTA**
   Configure and test **Password Hash Synchronization** and then compare it with **Pass-through Authentication**. Record what changes in sign-in flow, what remains on-premises, and what happens if the on-prem authentication path is unavailable. Make an explicit recommendation for which method Northbridge should use for its default user population and justify that decision operationally, not just functionally. Microsoft notes that PTA validates passwords directly against on-prem AD, while PHS is one of the cloud authentication methods used for hybrid identity; Microsoft also documents PHS as a backup option you can switch to when PTA agents cannot validate because of a significant on-prem failure. ([Microsoft Learn][3])

5. **Enable Seamless SSO and explain the Kerberos path**
   Implement **Seamless SSO** and test from the domain-joined client. Describe the sign-in experience before and after enabling it. Then write a short explanation of the Kerberos relationship involved, including the purpose of the `AZUREADSSOACC` computer account and why Seamless SSO is used with **PHS or PTA**, but not with AD FS. ([Microsoft Learn][4])

6. **Compare Entra Connect Sync vs Entra Cloud Sync**
   Build a comparison table for **Connect Sync** and **Cloud Sync** covering architecture, management model, agents, supported topology thinking, operational burden, and pilot/migration fit. Microsoft describes Cloud Sync as a modern, cloud-managed, lightweight agent-based synchronization service and notes that Connect Sync and Cloud Sync can coexist in the same forest during a pilot, as long as an object is in scope in only one tool. Use that principle in your design notes. ([Microsoft Learn][2])

7. **Pilot and transition to Entra Cloud Sync**
   Introduce a business decision: the company wants less dependence on a traditional sync server and prefers cloud-managed configuration. Pilot **Cloud Sync** for a separate OU or limited object set, ensuring there is no overlapping object ownership with Connect Sync. Validate post-sync results, then write what capabilities or operational patterns changed when you moved part of the environment from Connect Sync to Cloud Sync. ([Microsoft Learn][5])

8. **Implement a minimal AD FS use case**
   Stand up a basic **AD FS** scenario for one legacy-style use case. Keep the scope small. The point is not to build a full production federation farm, but to understand why organizations historically used AD FS, what dependency chain it introduces, and what kind of application or trust model pushed companies toward federation in the first place. Document where AD FS sits in the auth path and what new failure points it introduces.

9. **Phase out AD FS and move to modern authentication**
   Plan and execute a simplified retirement path for that AD FS use case by mapping it to Microsoft Entra-based authentication. Microsoft provides migration guidance and an AD FS migration experience for moving applications from AD FS to Microsoft Entra ID. Your job is to explain the cutover logic, the validation checks you would perform, and the rollback risk you would worry about most. ([Microsoft Learn][6])

10. **Validate monitoring and health visibility**
    Review **Microsoft Entra Connect Health** and identify what it would monitor in your hybrid setup, including sync and federated identity components. Explain why visibility matters more in hybrid identity than in cloud-only identity, and describe at least two issues you would want Health to help you detect early. Microsoft describes Entra Connect Health as a single lens for alerts, performance monitoring, and usage analytics across key identity components. ([Microsoft Learn][7])

### Challenge Injects

1. **Wrong OU scoping**
   A contractor OU was accidentally excluded from sync, and leadership reports that only some users appear in Microsoft 365. Identify the likely scoping problem, correct it, and explain why hybrid sync scoping mistakes are dangerous in real environments.

2. **PTA dependency failure**
   During testing, the on-prem path used by PTA becomes unavailable. Determine what sign-in impact users experience and explain how your chosen design would reduce or increase outage risk. Tie your answer back to PHS as a fallback design consideration. ([Microsoft Learn][8])

3. **Seamless SSO is inconsistent**
   Users on the domain-joined client still see interactive prompts. Investigate whether the client, browser path, domain join state, or Seamless SSO setup is the more likely fault domain. Explain what this teaches you about SSO being “simple” for the user but dependency-heavy in the backend. ([Microsoft Learn][4])

4. **Cloud Sync pilot overlap risk**
   A teammate suggests piloting Cloud Sync for the same users already managed by Connect Sync. Reject or redesign that plan and explain the object ownership risk. Microsoft explicitly notes that an object should be in scope in only one of the tools during coexistence. ([Microsoft Learn][9])

5. **Business asks to retire AD FS quickly**
   Leadership wants AD FS removed because of infrastructure cost and operational burden. Explain what you would assess before cutover, what applications must be inventoried first, and why federation retirement is an application migration problem as much as an authentication problem. ([Microsoft Learn][6])

### Knowledge Check (For the intern to answer in a brief summary)

1. In your own words, what is the most important architectural difference between **Microsoft Entra Connect Sync** and **Microsoft Entra Cloud Sync**, and why might an organization prefer one over the other? ([Microsoft Learn][2])

2. Compare **Password Hash Synchronization** and **Pass-through Authentication** in terms of security model, operational dependency, user experience, and failure impact. Which one would you recommend for a mid-sized company with limited identity staff, and why? ([Microsoft Learn][3])

3. How does **Seamless SSO** improve the sign-in experience, and what is the role of **Kerberos** and the `AZUREADSSOACC` account in making that work? Why is Seamless SSO not positioned for AD FS-based sign-in? ([Microsoft Learn][4])

4. During this lab, which system was the **source of authority** for user identity, password validation, and synchronization settings at each major phase? Answer phase by phase rather than giving one general statement.

5. Why did organizations use **AD FS** in the first place, and why are many now moving away from it toward Microsoft Entra cloud authentication and app integration? ([Microsoft Learn][6])

6. Why is **monitoring** more critical in hybrid identity than in cloud-only identity, and what kinds of operational issues should Microsoft Entra Connect Health help you detect? ([Microsoft Learn][7])

7. If on-prem AD stays authoritative for identities, what can and cannot be safely changed in Entra ID without creating confusion or drift?

8. In a merger or modernization project, when would you keep Connect Sync temporarily, when would you introduce Cloud Sync, and when would you remove AD FS?

### Deliverables

Submit the following:

* A **one-page architecture diagram** showing AD DS, domain-joined client, Microsoft Entra ID, Connect Sync, Cloud Sync agent path, PTA/PHS decision points, Seamless SSO flow, and AD FS placement
* A **brief implementation summary** of what you built
* A **comparison table** for Connect Sync vs Cloud Sync and PHS vs PTA
* A **migration note** explaining the transition from Connect Sync pilot design to Cloud Sync and from AD FS to Microsoft Entra authentication
* A **Kerberos and Seamless SSO explanation** written in plain engineering language
* A **troubleshooting log** covering at least two failures or misconfigurations you encountered or simulated
* A **lessons learned** section focused on design tradeoffs, not clicks

### Hint

Start by reviewing the Microsoft Learn guidance for:

* **Microsoft Entra Connect / hybrid identity authentication methods**
* **Seamless SSO**
* **Cloud Sync overview and migration decision guidance**
* **Federation to cloud authentication migration**
* **Microsoft Entra Connect Health**

The most important mindset for this lab is: **do not just prove that sync works; prove that you understand which component is responsible for what, and what breaks when that component fails.**

[1]: https://microsoftlearning.github.io/SC-300-Identity-and-Access-Administrator/Instructions/Labs/Lab_07_AddHybridIdentityWithAzureADConnect.html "
            Lab 07: OPTIONAL — Add Hybrid Identity with Microsoft Entra Connect | 
            
            SC-300-Identity-and-Access-Administrator
        "
[2]: https://learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/what-is-cloud-sync?utm_source=chatgpt.com "What is Microsoft Entra Cloud sync?"
[3]: https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/how-to-connect-pta?utm_source=chatgpt.com "Microsoft Entra Connect: Pass-through Authentication"
[4]: https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/how-to-connect-sso?utm_source=chatgpt.com "Microsoft Entra Connect: Seamless single sign-on"
[5]: https://learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/connect-to-cloud-sync-decision-guide?utm_source=chatgpt.com "Migrate from Microsoft Entra Connect to Cloud Sync"
[6]: https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/migrate-ad-fs-application-howto?utm_source=chatgpt.com "AD FS application migration to move AD FS apps ..."
[7]: https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/whatis-azure-ad-connect?utm_source=chatgpt.com "What is Microsoft Entra Connect and Connect Health."
[8]: https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/choose-ad-authn?utm_source=chatgpt.com "Authentication for Microsoft Entra hybrid identity solutions"
[9]: https://learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/plan-cloud-sync-topologies?utm_source=chatgpt.com "Microsoft Entra Cloud Sync supported topologies and ..."
