$studentprefix = "deploymentidvalue"
$githubAccount = "Your github account name here"
$resourcegroupName = "fabmedical-rg-" + $studentprefix
$cosmosDBName = "fabmedical-cdb-" + $studentprefix

Write-Host -ForeGround Green "Fetching CosmosDB Mongo connection string"
$mongodbConnectionString = `
    $(az cosmosdb keys list `
        --name $cosmosDBName `
        --resource-group $resourcegroupName `
        --type connection-strings `
        --query 'connectionStrings[0].connectionString')

Write-Host -ForeGround Green "Seeding CosmosDB database"
docker run -ti `
    -e MONGODB_CONNECTION="$mongodbConnectionString" `
    ghcr.io/$githubAccount/fabrikam-init:main

