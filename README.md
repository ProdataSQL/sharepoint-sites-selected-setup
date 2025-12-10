# Grant App Registration Access to SharePoint using Entra and Graph API
As you may be awar the legacy method fot granting "apps" access to sharepoint v Graph API is deprecared
https://learn.microsoft.com/en-us/sharepoint/dev/sp-add-ins/add-ins-and-azure-acs-retirements-faq

This repos gives scripts for an updated process.

### Pre-Requisites
You must have created an "app registration" and have the following parmaeters:
- Client ID
- Client Secret
- Hostname. The sharePoint Hostname, Eg prodata365.sharepoint.com
- Path . The Paht to the Site. Eg /sites/Test
- role. The permisions needed. generally either "write" or "read"

Powershell IDE (Either VS Code or Powershell IDE)

MS Graph Powershell Module installed:
Install-Module Microsoft.Graph


### Step 1 Create App Registration and set Graoh API Permisions
We assuem that this step is probably already done if you are not sure 
how to add an app registration and grant o MS Graph permissions, there is a deck in repos here
https://github.com/ProdataSQL/sharepoint-sites-selected-setup/blob/main/SharePoint%20SP%20Creation.pptx

### Step 2 Run Powershell to Grant the app Permissions
Using the sample script below populate the parameters for Client ID, Client Secret, Sharepoint Hostname, Path and required rols (read or write)
https://github.com/ProdataSQL/sharepoint-sites-selected-setup/blob/main/02_SharePoint-Permissions.ps1

When this runs, you will need to follow the instructiont to goto a web browser and validate using a device token

Then it will add permissons and display confirmation like below:

<img width="1890" height="232" alt="image" src="https://github.com/user-attachments/assets/1dda5bfe-e70d-418e-bb9f-e1f23c52d174" />


### Step 3  Test Accesss to SharePoint site
Now that we have set permissions we can test access by using te script below after setting paramaters: ClientId, TenantId, Hostname, Path
https://github.com/ProdataSQL/sharepoint-sites-selected-setup/blob/main/03_SharePoint-Test.ps1

This will prompt for the "Client Secret" and then test access to the SharePoint Site by listing directories.
<img width="400" height="341" alt="image" src="https://github.com/user-attachments/assets/821ff300-6b14-4cbc-aa2f-bbceb19030a1" />

When run the output should look liek below.
<img width="1153" height="222" alt="image" src="https://github.com/user-attachments/assets/fb573fdb-9d98-48a4-a075-e5e1dd8a1cbf" />







