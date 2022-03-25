@description('Provide SQL Server name')
param sqlserverName string
var sqlsName = '${sqlserverName}${uniqueString(resourceGroup().id)}'
@description('Provide SQL server login')
param sqllogin string
@description('Provide SQL server login password')
param sqlpassword string
@description('Provide SQL Database name')
param sqlDatabase string
@description('Provide Data Factory name')
param datafactory string
var adfName = '${datafactory}${uniqueString(resourceGroup().id)}'

param creationDate string = utcNow('yyyy-MM-dd')
param location string = resourceGroup().location

/*SQL Server*/
resource res_sqlServer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: sqlsName
  location: location
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

/*Azure Data Factory*/
resource res_ADF 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: adfName
  location: location
  tags: {
    created: creationDate
  }
}

/*SQL Database*/
resource res_sqlDatabase 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  name: '${sqlsName}/${sqlDatabase}'
  location: location
  tags: {
    created: creationDate
  }
  sku: {
    name: 'basic'
  }
  dependsOn:[
    res_sqlServer
  ]
}
