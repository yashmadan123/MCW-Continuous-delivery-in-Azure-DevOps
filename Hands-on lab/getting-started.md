
# Getting Started with Lab

1. Once the environment is provisioned, a virtual machine (JumpVM) and lab guide will get loaded in your browser. Use this virtual machine throughout the workshop to perform the the lab. You can see the number on lab guide bottom area to switch on different exercises of lab guide.

   ![](https://github.com/anushabc/MCW-Continuous-delivery-in-Azure-DevOps/blob/prod/Hands-on%20lab/media/image01.png?raw=true "Lab Environment")
   
   >Note: If you see any powershell windows is running in your VM, please do not close that as it's setting up some configurations inside the environment.
   
1. In the environment click on **ok** if you recevie a prompt regarding windows deprecation.

   ![](https://github.com/anushabc/MCW-Continuous-delivery-in-Azure-DevOps/blob/prod/Hands-on%20lab/media/imgdepre.png?raw=true "Lab Environment")     

1. To get the lab environment details, you can select **Environment Details** tab. Additionally, the credentials will also be emailed to your email address provided at registration. You can also open the Lab Guide on separate and full window by selecting the **Split Window** from lower right corner. Also, you can start, stop and restart virtual machines from **Resources** tab.

   ![](https://github.com/anushabc/MCW-Continuous-delivery-in-Azure-DevOps/blob/prod/Hands-on%20lab/media/image02.png?raw=true "Lab Environment")
 
    > You will see SUFFIX value on **Environment Details** tab, use it whereever you see SUFFIX or DeploymentID in lab steps.

## Set default browser

1. Within the LabVM, search for the **Deafult apps**.

    ![](media/default%20apps.png)
    
2. Scroll down to the web browser option at the bottom and select **Microsoft Edge** as the default browser.

    ![](media/MSedge.png)
    
 3. Close the setting tab by clicking on **X** from the top right corner.
 
1. If a **Welcome to Microsoft Azure** popup window appears, click **Maybe Later** to skip the tour.

1. Change the default Browser to Edge using the default apps setting option in Windows.

   ![In this screenshot of the selection of Edge browser is set as the default browser using the "Default apps' item in settings .](media/edge-default-app.png "Make Edge the default browser using 'Default Apps' ")  

1. Next, update the region + language settings of the Lab VM to region that is appropriate to your setting.

   ![Change the Region in settings to match current.](media/RegionChange.png "Change Region ")  

   ![Change the Language in settings to match current.](media/LanguageChange.png "Change Region ")  

## Login to Azure Portal
1. In the JumpVM, click on Azure portal shortcut of Microsoft Edge browser which is created on desktop.

   ![](https://github.com/anushabc/MCW-Continuous-delivery-in-Azure-DevOps/blob/prod/Hands-on%20lab/media/image01.png?raw=true "Lab Environment")
   
1. On **Sign in to Micsoft Azure** tab you will see login screen, in that enter following email/username and then click on **Next**. 
   * Email/Username: <inject key="AzureAdUserEmail"></inject>
   
      ![](media/imagesignin.png "Enter Email")
     
1. Now enter the following password and click on **Sign in**.
   * Password: <inject key="AzureAdUserPassword"></inject>
   
     ![](media/image8.png "Enter Password")
     
1. If you see the pop-up **Stay Signed in?**, click No

1. If you see the pop-up **You have free Azure Advisor recommendations!**, close the window to continue the lab.

1. If a **Welcome to Microsoft Azure** popup window appears, click **Maybe Later** to skip the tour.
   
1. Now you will see Azure Portal Dashboard, click on **Resource groups** from the Navigate panel to see the resource groups.

    ![](media/select-rg.png "Resource groups")
   
1. Confirm you have all resource group are present as shown below.

    ![](https://github.com/anushabc/MCW-Continuous-delivery-in-Azure-DevOps/blob/prod/Hands-on%20lab/media/image03.png?raw=true "Resource groups")
   
1. Now, click on the **Next** from lower right corner to move on next page.
