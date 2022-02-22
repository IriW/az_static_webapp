# PLAN FOR HOSTING STATIC WEB APP ON AZURE WITH CI/CD  (NOTE: THIS IS NOT "static website hosting" feature of Azure Storage.)

**CODE STORAGE:**     GitHub \
**SOURCE CONTROL:**   GIT \
**CI/CD:**           Azure DevOps (YAML)

  
###   **AZURE (ARM_Template plan):**
*  Resource: Static Web App 
*  Resource group: 
*  Name:
*  Hosting plan: free 
*  Azure functions region: westeurope 
*  Source: GitHub
	
### **AZURE DEVOPS PIPELINE:**
**VARIABLES** (keep this value secret):  
* deployment_token

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
