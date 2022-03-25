
## Deployment instructions
This documentation will take you through the steps required to deploy the Logic Apps samples on your Azure subscription.

### Prerequites:
- An Azure subscription with user access at least at contributor level
- A user account that has permission to create a service principal on the Azure Active Directory tenant of your subscription
- A GitHub account. You can create an account [here](https://github.com/join?source=login)

### Required steps:
1. Create a Resource Group
1. Create a service principal on Azure for GitHub Actions to be authorised deployment to Azure and add this service principal to your GitHub repo
1. Deploy Azure components
1. Deploy SQL Components
1. Deploy ADF components
1. Test the solution

## Step 1 : Create an Azure Resource Group

Login to Azure portal and create a [resource group as per instruction](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups)

Default RG name used in this demo is 'rg-demo-ais' and used as default value.

## Step 2 : Create service principal on Azure for GitHub

To create a Service Principal for GitHub to deploy resources to Azure, In the below command, replace {my-spn-name} with a unique name for your service principal and provide the {subscriptionId} and {resource-group-name}.

```
az ad sp create-for-rbac --name {my-spn-name} --role contributor --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group-name} --sdk-auth
```

Next, from the Azure Portal, open the CloudShell from the top menu bar. Then execute the above command.

You should get a result such as below. Keep note of it.

```
{
  "clientId": "f1ae8b22-.....",
  "clientSecret": "BX9J.....",
  "subscriptionId": "1d753eb......",
  "tenantId": "72f988b.....",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```
3. Copy and paste the json response from above Azure CloudShell to your GitHub Repository > Settings > Secrets > Actions > New repository secret. Name it : **AZURE_RBAC_CREDENTIALS**

## Step 3 : Deploy Azure components

In GitHub:
- In your GitHub repor, go to Actions
- click on Workflow 'Infra - Demo integration'
- Select Run worklow and enter parameters
   - The subscriptionId i.e. the GUID of your subscription
   - Resource group name:  your resource group name
   - SQL Server name: 'sqlsrv'
   - SQL Login id: 'adminuser'
   - SQL Login pwd: '[choose a password]'
   - SQL Database name: 'usecase3'
   - DataFactory name: 'adfdemo'
   - Function name: 'funcservicenow'
- Run workflow

## Step 4 : Deploy Logic App plan

In GitHub:
- In your GitHub repor, go to Actions
- click on Workflow 'Infra - Logic Apps plan'
- Select Run worklow and enter parameters
   - The subscriptionId i.e. the GUID of your subscription
   - Resource group name:  your resource group name
- Run workflow