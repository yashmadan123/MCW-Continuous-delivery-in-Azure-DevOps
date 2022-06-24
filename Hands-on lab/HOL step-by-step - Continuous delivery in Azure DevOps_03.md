## Exercise 4: Monitoring, Logging, and Continuous Deployment with Azure

Duration: 30 minutes

Fabrikam Medical Conferences has its first website for a customer running in the cloud, but deployment is still a largely manual process, and we have no insight into the behavior of the application in the cloud. In this exercise, we will add monitoring and logging to gain insight into the application usage in the cloud.

### Task 1: Set up Application Insights

1. Run the below-mentioned command in the termial to deploy the app insights, make sure that you are in the correct directory:

    > Note: Make sure to run the deploy-appinsights.ps1 script from the infrastructure folder
    ```
    ./deploy-appinsights.ps1
    ```
    
1. Now save the `AI Instrumentation Key` specified in the output - we will need it for a later step.

    ```bash
    The installed extension 'application-insights' is in preview.
    AI Instrumentation Key="55cade0c-197e-4489-961c-51e2e6423ea2"
    ```

1. Using PowerShell navigate to the `./content-web` folder in your GitHub lab files repository by running the below-mentioned command.

   ```
   cd ..
   cd .\content-web
   
   ```
   
1. Now using PowerShell, execute the following command to install JavaScript support for Application Insights via NPM to the web application frontend.

    ```bash
    npm install applicationinsights --save
    ```

1. In this step we'll updating the `app.js` file by adding and configuring Application Insights for the web application frontend in the local folder. Please run the command mentioned below.
   
    `Copy-Item -Path C:\Workspaces\lab\mcw-continuous-delivery-lab-files\keyscript.txt -Destination C:\Workspaces\lab\mcw-continuous-delivery-lab-files\content-web\app.js -PassThru`
    
    `$instrumentationKey` = $(az monitor app-insights component create --app fabmedicalai-<inject key="DeploymentID" enableCopy="false" /> --location westeurope --kind web --resource-group fabmedical-rg-<inject key="DeploymentID" enableCopy="false" /> --application-type web --retention-time 120 --query instrumentationKey)
    
    `(Get-Content -Path "C:\Workspaces\lab\mcw-continuous-delivery-lab-files\content-web\app.js") | ForEach-Object {$_ -Replace "UPDATE AI Instrumentation Key", $instrumentationKey} | Set-Content -Path "C:\Workspaces\lab\mcw-continuous-delivery-lab-files\content-web\app.js"`

1. Add and commit changes to your GitHub lab-files repository. From the root of the repository, execute the following:

    ```pwsh
    git add .
    git commit -m "Added Application Insights"
    git push
    ```

1. Wait for the GitHub Actions for your lab files repository to complete before executing the next step.

      ![](media/update8.png "Azure Boards")

1. Redeploy the web application by running the below commands in the **Visual studio Code** terminal:

    ```
    cd C:\Workspaces\lab\mcw-continuous-delivery-lab-files\infrastructure
    ./deploy-webapp.ps1
    ```
    
1. Browse to the `Overview` blade of the Azure Web Application detail page and find the web application URL. Browse to that URL to verify the deployment of the web application.
   
   ![The Azure Web Application Overview detail in Azure Portal.](media/hol-ex2-task2-step5-1.png "Azure Web Application Overview")


Congratulation, You have completed this workshop.
-------
    
