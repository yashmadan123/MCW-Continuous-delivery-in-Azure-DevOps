## Exercise 1: Create an Azure Resource Manager (ARM) template that can provision the web application, PostgreSQL database, and deployment slots in a single automated process

Duration: 45 Minutes

Tailspin Toys has requested three Azure environments (dev, test, production), each consisting of the following resources:

-   App Service

    -   Web App

    -   Deployment slots (for zero-downtime deployments)

-   PostgreSQL Server

    -   PostgreSQL Database

Since this solution is based on Azure Platform-as-a-Service (PaaS) technology, it should take advantage of that platform by utilizing automatic scale for the web app and the PostgreSQL Database PaaS service instead of running virtual machines.

### Task 1: Create an Azure Resource Manager (ARM) template using Azure Cloud Shell

1.  From within the **Azure Cloud Shell** locate the folder where you previously unzipped the Student Files. Open **Code** to this folder with the command below. It should also contain two sub-folders: **armtemplate** and **tailspintoysweb**.

    ```bash
    code .
    ```

    ![In the Code window, the Explorer window is displayed and it shows the student files folder that contains two sub-folders.](images/stepbystep/media/image22.png "Code Explorer")
  
2.  In the Code Explorer window, select the **armtemplate** sub-folder and open the **azuredeploy.json** file by selecting it.

    ![In the Code Explorer window, azuredeploy.json is highlighted under the armtemplate folder and the file is opened in the Editor window.](images/stepbystep/media/image23.png "Selecting the azuredeploy.json file")

3.  In the open editor window for the **azuredeploy.json**, scroll through the contents of the Azure Resource Manager Template. This template contains all the necessary code to deploy a Web App and a PostgreSQL database to Azure.

    >**Note**: If you would like to use this template in a future deployment of your own, it can be found in the ```https://github.com/Azure/azure-quickstart-templates```. This specific file can be found ```https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-webapp-managed-postgresql/azuredeploy.json```.

### Task 2: Configure the list of release environments parameters

1.  Next, you need to configure a list of release environments we'll be deploying to. Our scenario calls for adding three environments: dev, test, and production. This is going to require the addition of some manual code. At the top of the **azuredeploy.json** file, locate the following line of code (on or around line 4).
    ```json
    "parameters": {
    ```  

2.  Insert the following code immediately below that line of code.

    ```json
    "environment": {
        "type": "string",
        "metadata": {
            "description": "Name of environment"
        },
        "allowedValues": [
          "dev",
          "test",
          "production"
        ]
    },
    ```

    After adding the code, it will look like this:

    ![This is a screenshot of the code pasted inside the of the "parameters" object.](images/stepbystep/media/image24.png "Pasted block of JSON code adding environments")

    Save the file.

    >**Note**: The **environment** parameter will be used to generate environment specific names for our web app.
"1.  Locate the variable block of the **azuredeploy.json** and update with the following variable section with existing. Here, we are replacing **uniquestring** function with **DeploymentID** parameter.\n     ```\n    "variables": {"
      "webAppName": "[concat(parameters('siteName'), '-', parameters('environment'), '-', parameters('DeploymentID'))]",
      "databaseName": "[concat(parameters('siteName'), 'db', parameters('environment'), parameters('DeploymentID'))]",
      "serverName": "[concat(parameters('siteName'), 'pgserver', parameters('environment'), parameters('DeploymentID'))]",
      "hostingPlanName": "[concat(parameters('siteName'), 'serviceplan', parameters('DeploymentID'))]"
     },
     ```

### Task 3: Add a deployment slot for the "staging" version of the site

1.  Next, you need to add the "staging" deployment slot to the web app. This is used during a deployment to stage the new version of the web app. This is going to require the addition of some manual code. In the **azuredeploy.json** file, add the following code to the "resources" array, just above the element for the "connectionstrings" (on or around line 156).

    ```json
    {
        "apiVersion": "2016-08-01",
        "name": "staging",
        "type": "slots",
        "tags": {
            "displayName": "Deployment Slot: staging"
        },
        "location": "[resourceGroup().location]",
        "dependsOn": [
            "[resourceId('Microsoft.Web/Sites/', variables('webAppName'))]"
        ],
        "properties": {
        },
        "resources": []
    },
    ```

    After adding the code, it will look like this:

    Save the file.

    ![This is a screenshot of the code pasted just below the element for the application insights extension in the "resources" array.](images/stepbystep/media/image39.png "Pasted block of JSON code adding staging deployment slot")

    The complete ARM template should look like the following:

    ```json
    {
        "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "environment": {
                "type": "string",
                "metadata": {
                    "description": "Name of environment"
                },
                "allowedValues": [
                    "dev",
                    "test",
                    "production"
                ]
            },
            "siteName": {
                "type": "string",
                "defaultValue": "tailspintoys",
                "metadata": {
                    "description": "Name of azure web app"
                }
            },
            "administratorLogin": {
                "type": "string",
                "minLength": 1,
                "metadata": {
                    "description": "Database administrator login name"
                }
            },
            "administratorLoginPassword": {
                "type": "securestring",
                "minLength": 8,
                "maxLength": 128,
                "metadata": {
                    "description": "Database administrator password"
                }
            },
            "databaseSkuCapacity": {
                "type": "int",
                "defaultValue": 2,
                "allowedValues": [
                    2,
                    4,
                    8,
                    16,
                    32
                ],
                "metadata": {
                    "description": "Azure database for PostgreSQL compute capacity in vCores (2,4,8,16,32)"
                }
            },
            "databaseSkuName": {
                "type": "string",
                "defaultValue": "GP_Gen5_2",
                "allowedValues": [
                    "GP_Gen5_2",
                    "GP_Gen5_4",
                    "GP_Gen5_8",
                    "GP_Gen5_16",
                    "GP_Gen5_32",
                    "MO_Gen5_2",
                    "MO_Gen5_4",
                    "MO_Gen5_8",
                    "MO_Gen5_16",
                    "MO_Gen5_32"
                ],
                "metadata": {
                    "description": "Azure database for PostgreSQL sku name "
                }
            },
            "databaseSkuSizeMB": {
                "type": "int",
                "allowedValues": [
                    102400,
                    51200
                ],
                "defaultValue": 51200,
                "metadata": {
                    "description": "Azure database for PostgreSQL Sku Size "
                }
            },
            "databaseSkuTier": {
                "type": "string",
                "defaultValue": "GeneralPurpose",
                "allowedValues": [
                    "GeneralPurpose",
                    "MemoryOptimized"
                ],
                "metadata": {
                    "description": "Azure database for PostgreSQL pricing tier"
                }
            },
            "postgresqlVersion": {
                "type": "string",
                "allowedValues": [
                    "9.5",
                    "9.6"
                ],
                "defaultValue": "9.6",
                "metadata": {
                    "description": "PostgreSQL version"
                }
            },
            "location": {
                "type": "string",
                "defaultValue": "[resourceGroup().location]",
                "metadata": {
                    "description": "Location for all resources."
                }
            },
            "databaseskuFamily": {
                "type": "string",
                "defaultValue": "Gen5",
                "metadata": {
                    "description": "Azure database for PostgreSQL sku family"
                }
            }
        },
        "variables": {
            "webAppName": "[concat(parameters('siteName'), '-', parameters('environment'), '-', parameters('DeploymentID'))]",
            "databaseName": "[concat(parameters('siteName'), 'db', parameters('environment'), parameters('DeploymentID'))]",
            "serverName": "[concat(parameters('siteName'), 'pgserver', parameters('environment'), parameters('DeploymentID'))]",
            "hostingPlanName": "[concat(parameters('siteName'), 'serviceplan', parameters('DeploymentID'))]"
        },
        "resources": [
            {
                "apiVersion": "2016-09-01",
                "name": "[variables('hostingPlanName')]",
                "type": "Microsoft.Web/serverfarms",
                "location": "[parameters('location')]",
                "properties": {
                    "name": "[variables('hostingPlanName')]",
                    "workerSize": "1",
                    "hostingEnvironment": "",
                    "numberOfWorkers": 0
                },
                "sku": {
                    "Tier": "Standard",
                    "Name": "S1"
                }
            },
            {
                "apiVersion": "2016-08-01",
                "name": "[variables('webAppName')]",
                "type": "Microsoft.Web/sites",
                "location": "[parameters('location')]",
                "dependsOn": [
                    "[concat('Microsoft.Web/serverfarms/', variables('hostingPlanName'))]"
                ],
                "properties": {
                    "name": "[variables('webAppName')]",
                    "serverFarmId": "[variables('hostingPlanName')]",
                    "hostingEnvironment": ""
                },
                "resources": [
                    {
                        "apiVersion": "2016-08-01",
                        "name": "staging",
                        "type": "slots",
                        "tags": {
                            "displayName": "Deployment Slot: staging"
                        },
                        "location": "[resourceGroup().location]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Web/Sites/', variables('webAppName'))]"
                        ],
                        "properties": {},
                        "resources": []
                    },
                    {
                        "apiVersion": "2016-08-01",
                        "name": "connectionstrings",
                        "type": "config",
                        "dependsOn": [
                            "[concat('Microsoft.Web/sites/', variables('webAppName'))]"
                        ],
                        "properties": {
                            "defaultConnection": {
                                "value": "[concat('Database=', variables('databaseName'), ';Server=', reference(resourceId('Microsoft.DBforPostgreSQL/servers',variables('serverName'))).fullyQualifiedDomainName, ';User Id=', parameters('administratorLogin'),'@', variables('serverName'),';Password=', parameters('administratorLoginPassword'))]",
                                "type": "PostgreSQL"
                            }
                        }
                    }
                ]
            },
            {
                "apiVersion": "2017-12-01",
                "type": "Microsoft.DBforPostgreSQL/servers",
                "location": "[parameters('location')]",
                "name": "[variables('serverName')]",
                "sku": {
                    "name": "[parameters('databaseSkuName')]",
                    "tier": "[parameters('databaseSkuTier')]",
                    "capacity": "[parameters('databaseSkucapacity')]",
                    "size": "[parameters('databaseSkuSizeMB')]",
                    "family": "[parameters('databaseskuFamily')]"
                },
                "properties": {
                    "version": "[parameters('postgresqlVersion')]",
                    "administratorLogin": "[parameters('administratorLogin')]",
                    "administratorLoginPassword": "[parameters('administratorLoginPassword')]",
                    "storageMB": "[parameters('databaseSkuSizeMB')]"
                },
                "resources": [
                    {
                        "type": "firewallRules",
                        "apiVersion": "2017-12-01",
                        "dependsOn": [
                            "[concat('Microsoft.DBforPostgreSQL/servers/', variables('serverName'))]"
                        ],
                        "location": "[parameters('location')]",
                        "name": "[concat(variables('serverName'),'firewall')]",
                        "properties": {
                            "startIpAddress": "0.0.0.0",
                            "endIpAddress": "255.255.255.255"
                        }
                    },
                    {
                        "name": "[variables('databaseName')]",
                        "type": "databases",
                        "apiVersion": "2017-12-01",
                        "properties": {
                            "charset": "utf8",
                            "collation": "English_United States.1252"
                        },
                        "dependsOn": [
                            "[concat('Microsoft.DBforPostgreSQL/servers/', variables('serverName'))]"
                        ]
                    }
                ]
            }
        ]
    }    
    ```

### Task 4: Create the dev environment and deploy the template to Azure

Now that the template file has been updated, we'll deploy it several times to create each of our desired environments: *dev*, *test*, and *production*. Let's start with the **dev** environment.

1.  In the **Azure Cloud Shell** terminal, from the same folder that your ARM template resides in, enter the following command and press **Enter**:

    ```bash
    echo "Enter the Resource Group name:" &&
    read resourceGroupName &&
    echo "Enter the location (i.e. westus, centralus, eastus):" &&
    read location
    ```  

    >**Note**: The value for **Resource Group name** can be obtained from the **Environment details** tab

    Enter the name of a resource group you want to deploy the resources to (i.e. TailSpinToysRG). If it does not already exist, the template will create it. Then, select **Enter**.  

    Next, you're prompted to enter an Azure region (location) where you want to deploy your resources to (i.e. westus, centralus, eastus). 
    
    Enter the name of an Azure region and then press **Enter**.

2. Create the resource group:

    ```bash
    az group create --name $resourceGroupName --location "$location"
    ```  

3. Validate that you are in the correct directory. Run an `ls` command and you should see the output `azuredeploy.json`.  If you don't see that file, use `cd <directory>` to move to the correct folder.  

    ```bash  
    ls
    ```  

    ![Screen showing the output of the ls command, which lists the file azuredeploy.json](images/stepbystep/media/image1063.png "Running an ls command")

    >**Note**: Your path will likely be different than what is shown, as I put everything into a subfolder, which you likely did not do, and that is just fine.  

    Once you are certain you are in the correct folder, run the following command:  

    ```bash  
    az deployment group create --resource-group $resourceGroupName --template-file "azuredeploy.json"
    ```  
4.  Next, you're asked to enter a choice for environments you want to deploy to. The template will use your choice to concatenate the name of the environment with the name of the resource during provisioning. 
    
    For this first run, select the **dev** environment by entering **1** and then pressing **Enter**.
    
    ![In the Azure Cloud Shell window, we are prompted for the environment we want to deploy to.](images/stepbystep/media/image46.png "Azure Cloud Shell-provisioning dev environment") 
 5.  Then it will ask for the string value for the **DeployementID** and give the value of the DeploymentID from the **Environmet details** Tab.

5.  Supply an administrator login (username) for the PostgreSQL server and database. This will be the username credential you would need to enter to connect to your newly created database. 
    
    For the **administratorLogin**, enter a username value (e.g. *azureuser*) and then press **Enter**.

    ![In the Azure Cloud Shell window, we are prompted for the administrative username for the PostgreSQL server and database we want to create.](images/stepbystep/media/image47.png "Azure Cloud Shell-entering administrator credentials")

6.  Supply an administrator password for the PostgreSQL server and database. This will be the password credential you would need to enter to connect to your newly created database.

    >**Note**: The password must meet complexity requirements of 8 or more characters, must contain upper and lower case characters, must contain at least one number and at least one special character, e.g. "Database2020!"

    For the **administratorLoginPassword**, enter a value that meets the complexity requirements and then, press **Enter**.

7. This will kick off the provisioning process which takes a few minutes to create all the resources for the environment. This is indicated by the "Running" text displayed at the bottom of the Azure Cloud Shell while the command is executing.

    ![The Azure Cloud Shell is executing the template based on the parameters we provided.](images/stepbystep/media/image49.png "Azure Cloud Shell-Running")

8. After the template has completed, JSON is output to the Azure Cloud Shell window with a *Succeeded* message.

    ![The Azure Cloud Shell has succeeded in executing the template based on the parameters we provided.](images/stepbystep/media/image50.png "Azure Cloud Shell-Succeeded Highlighted")

    >**Note**: The above steps were used to provision the *dev* environment. Most of these same steps will be repeated for the *test* and *production* environments below.  

### Task 5: Create the test environment and deploy the template to Azure

The following steps are very similar to what was done in the previous task with the exception that you are now creating the **test** environment. 

Repeat the above steps and select to create the **2. test** environment. You can use the same values as used in the dev environment.

### Task 6: Create the production environment and deploy the template to Azure

The following steps are very similar to what was done in the previous task with the exception that you are now creating the **production** environment. 

Repeat the above steps and select to create the **3. production** environment. You can use the same values as used in the dev environment.

### Task 7: Review the resource groups

1. In the Azure Portal, navigate to the resource group where all of the resources have been deployed. It should look similar to the screenshot below.

    >**Note**: The specific names of the resources will be slightly different than what you see in the screenshot based on the unique identities assigned.

    ![The Azure Portal is showing all the deployed resources for the resource group we have been using.](images/stepbystep/media/image998.png "Listed Azure Portal Resources")  

### Task 8: Update the deployed App Services and Slots to use .NET 5   

After all of your environments are deployed, navigate to the azure portal and update all three app services and their corresponding staging slots to use the .Net 5 framework.  

1. In the window opened from the previous step, sort the deployed resources by type to get the App Services and their slots listed as the first six items (remember that the unique names will be different for you).  

    ![Screen showing all of the resource group resources, which are listed and sorted by type such that app service and slots are listed first.  All three app services and their slots are selected to note that each needs to be modified.](images/stepbystep/media/image1060.png "Resources by Type")  

2. For each of the three app services and their corresponding slots, you will do the following:  

    **Right-click on the name and select 'open in new tab'**.  

    ![Screen showing the first link in the list of resources is right-clicked and the option open in a new tab is selected.](images/stepbystep/media/image1061.png "Open in a new tab")  

    * **In the new tab, browse to configuration, then select `General Settings`.  On the General Settings tab, select the `.Net 5 (Early Access)` item from the dropdown for the .NET Framework Version.**  

    ![Screen showing selection of the option for the .Net 5 framework](images/stepbystep/media/image1062.png "Choosing the .Net 5 framework")  

    **After making the change, don't forget to `Save` the changes at the top**.

    >**Note**: The `(Early Access)` will likely go away at some point. When it does, just select the `.NET 5` option.

    Lastly, **do not forget to do this for all six entries, especially the staging slots where your pipeline will deploy the solutions**.

