#
# Code to Test using a Service Principal (App Registration) to access a SharePoint Site via Microsoft Graph API
#
# Pre-requisites:
$ErrorActionPreference = "Stop"

$ClientId = "b9b25184-7305-4612-89cb-41106bc4d80a"
$TenantId ="d8ca992a-5fbe-40b2-9b8b-844e198c4c94"
$Hostname = "prodata365.sharepoint.com"  # Sharepoint Top Level URL 
$ClientSecret = "xxx"
$Path = "/sites/Test"                    # Path to the site. Eg /Sites/[Site Name]

# Prompt for secret if missing


$SecureSecret = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential($ClientId, $SecureSecret)

# Connect
Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $Cred -NoWelcome
$Site = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/${Hostname}:${Path}:"
$SiteId = $Site.id

#Get All  Drives in Site
Write-Host("Drives in Site ID [$SiteId]:")
Get-MgSiteDrive -SiteId $SiteId | Select-Object Name, Id |  Format-List 