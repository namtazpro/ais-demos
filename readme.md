
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

## Step 3 : Deploy SQL DB, ADF and Function-app

In GitHub:
- In your GitHub repo, go to Actions
- click on Workflow 'Deploy Infra - ADF-SQL-Function-App'
- Select Run worklow and enter parameters
   - The subscriptionId i.e. the GUID of your subscription
   - Resource group name:  your resource group name (or use default)
   - SQL Server name: 'sqlsrv'
   - SQL Login id: 'virou'
   - SQL Login pwd: '[choose a password]'
   - SQL Database name: 'usecase3'
   - DataFactory name: 'adfdemo'
   - Function name: 'snowvro123456'
- Run workflow

## Step 4 : Deploy LogicApps-app
TO DO: generate a unique name for the LogicApp blob storage and a unique name for the LogicApp (in parameters file)

In GitHub:
- In your GitHub repo, go to Actions
- click on Workflow 'Deploy Infra - LogicApps-App'
- Select Run worklow and enter parameters
   - The subscriptionId i.e. the GUID of your subscription
   - Resource group name:  your resource group name (or use default)
- Run workflow

## Step 4 : Deploy and configure storage account

In GitHub:
- In your GitHub repo, go to Actions
- click on Workflow `Deploy Infra - storage account`
- Select Run worklow and enter parameters
   - The subscriptionId i.e. the GUID of your subscription
   - Resource group name:  your resource group name (or use default)
   - Storage account name: 'blobfilemgmt12345'
- Run workflow and wait until it completes ...
- Once the storage account has been successfully completed, in the Azure Portal, go to the blob storage blobfilemgmt12345 then click on Containers and select container `outboundfiles`.
- Click `Add Directory` and enter 'usecase4' then save.
- In the storage account, select `SFTP` under Settings
- Click `Add local user` and name Username to 'integuser'. Select `SSH Password`
- Under Container permissions, select `Containers` 'outbound files'
- In the list below, for `outboundfiles`, select permissions 'All'
- Under `Home directory` enter 'outboundfiles/usecase4' (the portal checks if the path exists)
- Click Add
- *IMPORTANT*: copy the SSH password when the pop-up appears and save it in a safe place

## Step 5 : Deploy the ServiceNow Function

In GitHub:
- In your GitHub repo, go to Actions
- click on Workflow 'Deploy App - Function proj to Azure Function App'
- Select Run worklow and enter parameters
   - The subscriptionId i.e. the GUID of your subscription
   - Resource group name:  your resource group name (or use default)
   - Function App name: snowvro123456
- Run workflow

   
## Step 5 : Deploy SQL objects & test data

In Azure Portal:
- Go to the SQL Database
- Select Query editor (preview)
- Enter login details. The first time you will get an error indicating the your IP is not allowed. Click on the provided list in the error message to add your IP to the SQL Server firewall.
- Once logged-in, in the 'Query 1' pane, copy and paste then 'Run' the scripts, in that order, located in:
   -  [your repo]/ais-demo/sql/stored_procedure.sql
   -  [your repo]/ais-demo/sql/tables.sql
   -  [your repo]/ais-demo/sql/table_1_datainsert.sql

## Step 5 : update ADF

In Azure Portal:
- Go to the Azure Data Factory instance
- Click on 'Open Azure Data Factory Studio' panel under Getting started
- Once opened in another browse tab, click on 'Set up code repository'
- Select type 'GitHub' and enter your github username. Click Continue. The process will sign you in and grant ADF access to your repo
- Under Repository name, select ais-demos. Select `main` branch for both Collaboration and Publish branch.
- Under Root folder, enter `/adf`
- Unselect Import existing resources and Apply
- From the Author panel, select the `main branch` from the top left corner. 4 datasets and 1 pipeline should appear in the Factory Resources.
- Go to Manage panel and connect the `adl_blobfilemanagement` Azure Data Lake Storage Gen2 to your instance. Use the `From Azure Subscription` option to select your blob storage account. Make sure to Test connection on the bottom right hand side
- Do the same for the AzureSql_usecase3. Use the `From Azure Subscription` option to select your sql server and database. Enter the user name and password. Test the connection. The first time you will get an error with a provided ip address. Add the ip address to the sql server [firewall](https://docs.microsoft.com/en-us/azure/azure-sql/database/firewall-create-server-level-portal-quickstart)
- From the Author panel, select all Dataset and Test the connection.
- From the Author panel, click `Publish` to take changes into account in your ADF instance.

## Step 6: Deploy Logic Apps workflows
In
