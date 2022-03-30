param storageAccountName string
param containerName string = 'outboundfiles'
param containerName2 string = 'tempstoreforprocessing'
param location string = resourceGroup().location
param creationDate string = utcNow('yyyy-MM-dd')

resource sa 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  tags: {
    created: creationDate
  }
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    isHnsEnabled: true
    isSftpEnabled: true
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${sa.name}/default/${containerName}'
}

resource container2 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${sa.name}/default/${containerName2}'
}
