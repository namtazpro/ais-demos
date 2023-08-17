@description('Provide SQL Server name')
param sqlserverName string

var sqlsName = '${sqlserverName}${uniqueString(resourceGroup().id)}'

@description('Provide SQL server login')
param sqllogin string

@description('Provide SQL server login password')
@secure()
param sqlpassword string

@description('Provide SQL Database name')
param sqlDatabase string

@description('Provide Data Factory name')
param datafactory string

var adfName = '${datafactory}${uniqueString(resourceGroup().id)}'

param creationDate string = utcNow('yyyy-MM-dd')
param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
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

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabase
  location: location
  tags: {
    created: creationDate
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
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


