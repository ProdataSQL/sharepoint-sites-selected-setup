#
# Code to Set SharePint Permissions for an app registration
#
# Pre-requisites:
# Install-Module Connect-MgGraph
$ErrorActionPreference = "Stop"

# 1. Run this line to authenticate to Entra and Graph API
# You Must be a SharePoint ot Site Admin of the Site you want to manage
Connect-MgGraph -Scopes "Sites.FullControl.All,Application.Read.All" -UseDeviceCode


# 2. Set these parameters
$AppId = "b9b25184-7305-4612-89cb-41106bc4d80a"
$Hostname = "prodata365.sharepoint.com"  # Sharepoint Top Level URL 
$Path = "/sites/Test"                    # Path to the site. Eg /Sites/[Site Name]
$roles =@("write")               # Permissions to grant. Can be "read" or "write"


# Validate Site 
try { 
    $Site = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/sites/${Hostname}:${Path}:"
} 
catch {
    Write-Error @"
Site [${Hostname}${Path}] not found or you do not have access to it."

Full Error:
$_.Exception.Message
"@
}
$SiteId = $Site.id
try {
    $appDisplayName = (Get-MgApplication -Filter "appId eq '$appId'").DisplayName
}
catch {
    Write-Error "App registration with client ID [$AppId] not found. Check App Registrations in Entra ID."
}

Write-Host("Granting App [$appDisplayName] to Site ID [$SiteId]")

$Body = @{
    roles = $roles
    grantedToIdentities = @(
        @{
            application = @{
                id = $AppId
                displayName = $appDisplayName
            }
        }
    )
} | ConvertTo-Json -Depth 10

Invoke-MgGraphRequest -Method POST `
  -Uri "https://graph.microsoft.com/v1.0/sites/$SiteId/permissions" `
  -Body $Body


  