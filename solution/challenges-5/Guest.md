### Designing the control Plane 

For the guest/vendor collobaration to our contoso organization. A dedicated security group is only allowded to invite the guest users. 

To enforce such restriction, 

Under Entra 

1. External Identities ->
2. External Collobaration Setting -> 
3. Under Guest Invite Setting; allowing Only users assigned to specific admin roles can invite guest users

![control-plane](control-plane.png)

This is the global tenant setting. 

Now, we need to create a user with required roles, following the principal of least priviledge, providing just required access to perform the job. i.e. Invite the external User

![guest-inviter](guest-inviter.png)

### Automation Application

For the automation capabilities, we have to create a enterprise application with limited scope of inviting the user.


User.Invite.All: https://graphpermissions.merill.net/permission/User.Invite.All?tabs=apiv1%2Cinvitation1

Since, we have guardrails in the tenant level that only users/app in the specific security group or specific admin role can invite the user. We have to add this application to the security group.