
## Exercise 2: Continuous Delivery

Duration: 40 minutes

The Fabrikam Medical Conferences developer workflow has been improved. We are ready to consider migrating from running on-premises to a cloud implementation to reduce maintenance costs and facilitate scaling when necessary. We will take steps to run the containerized application in the cloud as well as automate its deployment.

### Task 1: Set up Cloud Infrastructure

1. In the Azure Portal navigate to **fabmedical** resource group and verify CosmosDB instance, the App Service Plan, and the Web App resources which are pre deployed. We will be using this resources in the next steps of the lab.

    ![Azure Resource Group containing cloud resources to which GitHub will deploy containers via the workflows defined in previous steps.](media/hol-ex2-task1-step5-1.png "Azure Resource Group")


2. In the LabVM, open the `seed-cosmosdb.ps1` PowerShell script in the `C:\Workspaces\lab\mcw-continuous-delivery-lab-files\infrastructure` folder of your lab files GitHub repository and replace `$studentprefix` variable value with **<inject key="Deploymentid" />**, add `$githubRepo = "Your gihub repository name here"` variable.

    ```pwsh
    $studentprefix = "Your 3 letter abbreviation here"
    $githubAccount = "hatboyzero"
    $githubRepo = "mcw-continuous-delivery-lab-files"
    $resourcegroupName = "fabmedical-rg-" + $studentprefix
    $cosmosDBName = "fabmedical-cdb-" + $studentprefix
    ```
   
   ![](media/seedcosmos.png)

3. Observe the call to fetch the MongoDB connection string for the CosmosDB database.

    ```pwsh
    # Fetch CosmosDB Mongo connection string
    $mongodbConnectionString = `
        $(az cosmosdb keys list `
            --name $cosmosDBName `
            --resource-group $resourcegroupName `
            --type connection-strings `
            --query 'connectionStrings[0].connectionString')
    ```

4. Note the call to seed the CosmosDB database using the MongoDB connection string passed as an environment variable (`MONGODB_CONNECTION`) to the `fabrikam-init` docker image we built in the previous exercise using `docker-compose`.

    ```pwsh
    # Seed CosmosDB database
    docker run -ti `
        -e MONGODB_CONNECTION="$mongodbConnectionString" `
        docker.pkg.github.com/$githubAccount/$githubRepo/fabrikam-init
    ```
    
5.  Before you pull this image, you may need to authenticate with the GitHub Docker registry. To do this, run the following command before you execute the script. Fill the placeholders appropriately. 

    **Username is case sensitive make sure you enter the exact username and personal access token.**

    ```powershell
    docker login ghcr.io -u USERNAME -p PERSONAL ACCESS TOKEN 
    ```

6. Run the `seed-cosmosdb.ps1` PowerShell script. Browse to the Azure Portal and navigate to **fabmedical-cdb-<inject key="DeploymentID" enableCopy="false" />** Cosmos DB resource and  and verify that the CosmosDB instance has been seeded.

     ```pwsh
     ./seed-cosmosdb.ps1
     ```
       
7. Once the script execution is completed, Browse to the Azure Portal and navigate to **fabmedical-cdb-<inject key="DeploymentID" enableCopy="false" />** Cosmos DB resource and select **Data Explorer** from the left menu  and verify that the CosmosDB instance has been seeded.

    ![Azure CosmosDB contents displayed via the CosmosDB explorer in the Azure CosmosDB resource detail.](media/hol-ex2-task1-step9-1.png "Azure CosmosDB Seeded Contents")

8. Below the `sessions` collection, select **Scale & Settings (1)** and **Indexing Policy (2)**.

    ![Opening indexing policy for the sessions collection.](./media/sessions-collection-indexing-policy.png "Indexing policy configuration")

9. Create a Single Field indexing policy for the `startTime` field (1). Then, select **Save** (2).

    ![Creating an indexing policy for the startTime field.](./media/start-time-indexing-mongo.png "startTine field indexing")

10. Open the `configure-webapp.ps1` PowerShell script in the `C:\Workspaces\lab\mcw-continuous-delivery-lab-files\infrastructure` folder of your lab files GitHub repository and replace `$studentprefix` variable value with **<inject key="Deploymentid" />** on the first line. Once the changes is done, make sure to save the file.

    ```pswh
    $studentprefix = "hbs"                                  # <-- Modify this value
    $resourcegroupName = "fabmedical-rg-" + $studentprefix
    $cosmosDBName = "fabmedical-cdb-" + $studentprefix
    ```

11. Observe the call to configure the Azure Web App using the MongoDB connection string passed as an environment variable (`MONGODB_CONNECTION`) to the web application.

    ```pwsh
    # Configure Web App
    az webapp config appsettings set `
        --name $webappName `
        --resource-group $resourcegroupName `
        --settings MONGODB_CONNECTION=$mongodbConnectionString
    ```

12. Run the `configure-webapp.ps1` PowerShell script.

    ```pwsh
    cd C:\Workspaces\lab\mcw-continuous-delivery-lab-files\infrastructure
    ./configure-webapp.ps1
    ```

13. Once the script execution is completed, Browse to the Azure Portal and search for **fabmedical-web-<inject key="DeploymentID" enableCopy="false" />** App service and select **Configuration** from left side menu and verify that the environment variable `MONGODB_CONNECTION` has been added to the Azure Web Application settings.

    ![Azure Web Application settings reflecting the `MONGODB_CONNECTION` environment variable configured via PowerShell.](media/hol-ex2-task1-step12-1.png "Azure Web Application settings")

14. Take the GitHub Personal Access Token you obtained in the Before the Hands-On Lab guided instruction and assign it to the `GITHUB_TOKEN` environment variable in PowerShell. We will need this environment variable for the `deploy-webapp.ps1` PowerShell script, but we do not want to add it to any files that may get committed to the repository since it is a secret value.

    ```pwsh
    $env:CR_PAT="<GitHub Personal Access Token>"
    ```

### Task 2: Deployment Automation to Azure Web App

1. Open the `deploy-webapp.ps1` PowerShell script in the `infrastructure` folder of your lab files GitHub repository and replace `$studentprefix` variable value with **<inject key="Deploymentid" />** on the first line and add your GitHub account name for the `$githubAccount` variable on the second line. Once the changes is done make sure to save the file. 

    ```pwsh
    $studentprefix = "Your 3 letter abbreviation here"                                  # <-- Modify this value
    $githubAccount = "hatboyzero"                           # <-- Modify this value
    $resourcegroupName = "fabmedical-rg-" + $studentprefix
    $webappName = "fabmedical-web-" + $studentprefix
    ```

2. Note the call to deploy the Azure Web Application using the `docker-compose.yml` file we modified in the previous exercise.

    ```pwsh
    # Deploy Azure Web App
    az webapp config container set `
        --docker-registry-server-password $env:CR_PAT `
        --docker-registry-server-url https://docker.pkg.github.com `
        --docker-registry-server-user $githubAccount `
        --multicontainer-config-file ./../docker-compose.yml `
        --multicontainer-config-type COMPOSE `
        --name $webappName `
        --resource-group $resourcegroupName
    ```

3. Run the `deploy-webapp.ps1` PowerShell script.

     ```pwsh
    ./deploy-webapp.ps1
    ```

    > **Note**: Make sure to run the `deploy-webapp.ps1` script from the `infrastructure` folder

4. Browse to the Azure Portal and verify that the Azure Web Application is running by checking the `Log stream` blade of the Azure Web Application detail page.

    ![Azure Web Application Log Stream displaying the STDOUT and STDERR output of the running container.](media/hol-ex2-task2-step4-1.png "Azure Web Application Log Stream")

5. Browse to the `Overview` blade of the Azure Web Application detail page and find the web application URL. Browse to that URL to verify the deployment of the web application. It might take few minutes for the web application to reflect new changes.

    ![The Azure Web Application Overview detail in Azure Portal.](media/hol-ex2-task2-step5-1.png "Azure Web Application Overview")

    >Note: If you see any nginx error while browsing the App URL, that's fine as it will take a few minutes to reflect the changes.
    
    ![The Contoso Conference website hosted in Azure.](media/hol-ex2-task2-step5-2.png "Azure hosted Web Application")
    
### Task 3: Continuous Deployment with GitHub Actions

With the infrastructure in place, we can set up continuous deployment with GitHub Actions.

 1. Go to Environment details click on **Service principle Credentials** copy **Application id(clientId)** , **clientSecret(secretkey)** , **subscriptionId** and **tenantId** 
    
     ![spcreds](https://raw.githubusercontent.com/CloudLabsAI-Azure/AIW-DevOps/main/Assets/sp-creds-auth.png)
    
    Replace the values that you copied in the below Json.
     ```pwsh
     {
         "clientId": "...",
         "clientSecret": "...",
         "subscriptionId": "...",
         "tenantId": "...",
         "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
         "resourceManagerEndpointUrl": "https://management.azure.com/",
         "activeDirectoryGraphResourceId": "https://graph.windows.net/",
         "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
         "galleryEndpointUrl": "https://gallery.azure.com/",
         "managementEndpointUrl": "https://management.core.windows.net/"
     }
     ```
    Copy the complete JSON output to your clipboard.

 1. In your GitHub lab files repository, navigate to the `Secrets` > `Actions` blade in the `Settings` tag and create a new repository secret named `AZURE_CREDENTIALS`. Paste the JSON output copied in the previous step to the secret value and click on `Add secret`.

     ![azurecred](media/azurecred.png)
   
 1. Edit the `docker-publish.yml` file in the `.github\workflows` folder using Github. Add the job present in the file URL mentioned below to the end of the `docker-publish.yml` file.

    > **Note**: Make sure to change the student prefix for the last action in the `deploy` job.
    
    `https://raw.githubusercontent.com/CloudLabs-MCW/MCW-Continuous-delivery-in-Azure-DevOps/prod/Hands-on%20lab/deploy-job.yml`
    
    ![azurecred](media/update7.png)
    
 1. Commit the YAML file to your `main` branch. A GitHub action should begin to execute for the updated workflow.

    > **Note**: Make sure that your Actions workflow file does not contain any syntax errors, which may appear when you copy and paste. They are highlighted in the editor or when the Action tries to run, as shown below.

    ![GitHub Actions workflow file syntax error.](media/github-actions-workflow-file-error.png "Syntax error in Actions workflow file")

 1. Observe that the action builds the docker images, pushes them to the container registry, and deploys them to the Azure web application.

     ![GitHub Action detail reflecting Docker ](media/hol-ex3-task2-step8-1.png "GitHub Action detail")

 1. Perform a `git pull` on your local repository folder to fetch the latest changes from GitHub.


