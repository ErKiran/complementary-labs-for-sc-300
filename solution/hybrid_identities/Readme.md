1. **Build the AD DS foundation**
   Deploy a Windows Server, promote it to a domain controller, and create a simple OU and group structure that reflects business units and admin boundaries. Create a small set of users with realistic naming and role patterns. As you do this, document which system is the **source of authority** for each identity attribute at this stage.

   I have installed 

   * Windows Server 2025 
   * Windows 11 

   on a VM Virtual Box 

The windows server has been promoted to the AD DS. I have configured static IP address to both Server and Window. 

In order to both VM to communicate they needs to be on same network which can be configured as 

![11-net](evidences/11-net.png)

![25-net](evidences/22-net.png)

Once, we set up the Network connection, we can test ping command from Windows-11 and Windows Server 2025 

![11](evidences/ping-11.png)

![25](evidences/ping_server_25.png)

2. **Join a client and validate domain authentication**
   Join a Windows 11 client to the domain and sign in with a domain user. Validate that the user receives a normal domain logon experience. Explain what role Kerberos plays here, what the domain controller is doing during authentication, and why this matters before you introduce Microsoft Entra.

The windows 11 by default is the member of workgroup which I need to change to make it member of the domain

![workspace](evidences/domain_member.png)

To join the computer to the domain we need to log in as the administrator. 

![admin](evidences/domain_admin.png)

The Windows 11 will be restarted 
In the active Directory Domain Services, the joined computer appears under the Computers

![computers](evidences/ad_computer.png)

We will see this screen 

![login](evidences/login_screen.png)

Depending on the setting on the active directory for the password we may have to change the default password and use a new one.

To further confirm, run `whoami` command

![whoami](evidences/whoami.png)

Furthermore, we can verify the Ticket Granting Ticket (TGT) and service ticket for the user with `klist` command. 

![klist](evidences/klist.png)

To view the TGT currently held by the user we can use `klist tgt` command. The TGT is issued by the Kerberos Key Distribution Center (KDC) on the Domain Controller after a successful authentication.

![klist-tgt](evidences/klist-tgt.png)

Inorder to view the group policy setting that have been applied to a user we can use `gpresult`. It helps to verift which GPOs were processed, filtered, or denied during logon and policy referesh.

![gpresult](evidences/gpresult.png)

The Domain controller (DC) acts as a KDC it verifies logon, issues a TGT, and then issues a service tickets when accessing domain resources.

It provides secure, centralized, and scalable authentication, enabling Single Sign-On.

3. **Implement Microsoft Entra Connect Sync**
   Integrate the on-prem AD forest with Microsoft Entra ID using **Microsoft Entra Connect Sync**. Scope synchronization so only a selected OU or set of test objects syncs. Verify that users and groups appear correctly in Entra ID, and check whether important attributes such as UPN and display name align with your intended cloud sign-in model. The goal here is to understand traditional hybrid sync architecture and on-premises sync server dependencies. 

So, far we have static IP address configured. Inorder to sync with Entra we need to enable DHCP configuration and connect AD DS and Domain Computer with each other.

Entra Connect Sync 

![sync](evidences/EntraConnect.png)

We need to download the Entra Connect Sync and use the express setting for basic lab needs.

![express](evidences/express_settings.png)

Pop up for the Entra Connect

![connect](evidences/connect_to_entra.png)

I received the error due to dependency with Internet Explorer. 

![explorer](evidences/internet_explorer_error.png)

Resolving this issue, with setting edge as a default browser. 

Next, connect to AD DS,

![ad_ds](evidences/connect_to_ad_ds.png)

While connecting to AD DS, I got time skew error which I solve with `ntp` sync 

![skew_error](evidences/time_skew.png)

The sync finally completed, 

![config_complete](evidences/config_complete.png)

Once, the Configuration is done, we can proceed with Syncing specific **Organization Unit** i.e. lab_users

![lab](evidences/sync_lab_users_domain.png)

![completed](evidences/ou_sync_complete.png)

The synced user in the Entra ID 

![synced_users](evidences/sukaf.png)