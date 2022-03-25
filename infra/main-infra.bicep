@description('Provide SQL Server name')
param sqlserverName string
@description('Provide SQL server login')
param sqllogin string
@description('Provide SQL server login password')
param sqlpassword string
@description('Provide SQL Database name')
param sqlDatabase string
@description('Provide Data Factory name')
param datafactory string
@description('Provide Logic Apps name')

param creationDate string = utcNow('yyyy-MM-dd')

/*SQL Server*/
resource res_sqlServer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: sqlserverName
  location: resourceGroup().location
  tags: {
    created: creationDate
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    administratorLogin: sqllogin
    administratorLoginPassword: sqlpassword
  }
}

/*SQL Database*/
resource res_sqlDatabase 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  name: '${sqlserverName}/${sqlDatabase}'
  location: resourceGroup().location
  tags: {
    created: creationDate
  }
  sku: {
    name: 'basic'
  }
}

/*Azure Data Factory*/
resource res_ADF 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: datafactory
  location: resourceGroup().location
  tags: {
    created: creationDate
  }
}

