$studentprefix = "deploymentidvalue"
$resourcegroupName = "fabmedical-rg-" + $studentprefix
$cosmosDBName = "fabmedical-cdb-" + $studentprefix
$webappName = "fabmedical-web-" + $studentprefix

Write-Host -ForeGround Green "Fetching CosmosDB Mongo connection string"
$mongodbConnectionString = `
    $(az cosmosdb keys list `
        --name $cosmosDBName `
        --resource-group $resourcegroupName `
        --type connection-strings `
        --query 'connectionStrings[0].connectionString')

Write-Host -ForeGround Green "Configuring Web App"
az webapp config appsettings set `
    --name $webappName `
    --resource-group $resourcegroupName `
    --settings MONGODB_CONNECTION=$mongodbConnectionString
