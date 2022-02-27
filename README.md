# PLAN FOR HOSTING STATIC WEB APP ON AZURE WITH CI/CD  (NOTE: THIS IS NOT "static website hosting" feature of Azure Storage.)

**CODE STORAGE:**     GitHub \
**SOURCE CONTROL:**   GIT \
**CI/CD:**           Azure DevOps (YAML)

  
###   **AZURE (~~ARM_~~ Bicep Template plan):**
*  Resource: Static Web App 
*  Resource group: MSYAML
*  Name: irinchi-website-[...some_unique_nrs_here...]
*  Hosting plan: free 
*  Azure functions region: germanywestcentral 
*  Source: GitHub
	
### **AZURE DEVOPS PIPELINE:**
**VARIABLES**:  
* $(ServiceConnectionName)
* $(ResourceGroupName)
* $(EnvironmentType)
* $(deployMsYamlIrinaStorageAccount) = true by 1st run deploys the storage account. Next, change to false to disable it for next runs.

## Configuration of Azure Static WebApp is in staticwebapp.config.json. 
### It defines:
* Routing
* Authentication
* Authorization
* Fallback rules
* HTTP response overrides
* Global HTTP header definitions
* Custom MIME types
* Networking
