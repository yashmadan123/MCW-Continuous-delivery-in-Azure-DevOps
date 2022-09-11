# Exercise 1: Dev Box

## Task 1: Create Dev box definition

1. In Azure portal, search for **Microsoft dev box** **(1)**, and then click on it from the search results **(2)**.

  ![](media/e101.png)
  
1. Now on the left hand side blade click on **Dev Centers** **(1)** and then click on **devcenter-[DID]** **(2)**.

  ![](media/e109.png)
  
1. On the left hand side pane, click on **Dev box definitions** **(1)**, and click on **+ Create** **(2)**.

  ![](media/e110.png)
  
1. Now under Create dev box definition window, add the below details and then click on **Create** **(6)**.

  - Name: **devboxdef-01**
  - Image: **Windows 11 Enterprise + Microsoft 365 Apps 21H2**
  - Image version: **Latest**
  - Compute: **4vCPU, 16 GB RAM**
  - Storage: **256 GB SSD**

  ![](media/e112.png)
  
1. Once the definition is created, In Azure portal, search for **Microsoft dev box** **(1)**, and then click on it from the search results **(2)**.

  ![](media/e101.png)
  
>**Note:** Wait for the deployment to complete before proceeding with the lab.
  
## Task 2: Create Network connection

1. On the left hand blade, click on **Network Connections** **(1)**, and then click on **Create network connection** **(2)**.

  ![](media/e113.png)
  
1. Now under *Create a network connection* window, enter the following details and click on **Review and Create**.

  - Domain join type: **Azure active directory join**
  - ResourceGroup: **devbox-rg**
  - Name: **devbox-network**
  - Virtual network: ****
  - Subnet: ****

  ![](media/e116.png)

1. After deployment validation is passed, click on **Create**.

  ![](media/e115.png)
  
>**Note:** Wait for the deployment to complete before proceeding with the lab.
  
## Task 3: Create dev box pool

1. Return to Microsoft dev box, and click on **Dev box pools** **(1)** on the left hand side pane and then click on **Add New** **(2)**.

  ![](media/e102.png)
  
2. Under *Create a dev box pool* window, enter the following details and click on **Create**.

  - Name:**devbox-pool**
  - Dev box definition: **devboxdef-01**
  - Network Connection: **devbox-network**
  - Dev box Creator Privileges: **Local Administrator**
  - Licensing: Check the checkbox
  
  ![](media/e103.png)
