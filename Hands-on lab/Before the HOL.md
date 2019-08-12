![](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png "Microsoft Cloud Workshops")

<div class="MCWHeader1">
Continuous delivery in Azure DevOps
</div>

<div class="MCWHeader2">
Before the hands-on lab setup guide
</div>

<div class="MCWHeader3">
August 2019
</div>


Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2019 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents**

<!-- TOC -->

- [Continuous delivery in Azure DevOps before the hands-on lab setup guide](#continuous-delivery-in-azure-devops-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
    - [Prerequisites](#prerequisites)
    - [Task 1: Use Azure Shell as your development environment](#task-1-use-azure-shell-as-your-development-environment)
    - [Task 2: Download the exercise files](#task-2-download-the-exercise-files)

<!-- /TOC -->

# Continuous delivery in Azure DevOps before the hands-on lab setup guide

## Requirements

1.  Microsoft Azure subscription

2.  Local machine or a virtual machine configured with:

    -   Visual Studio Code

    -   Git command-line interface (CLI)

## Before the hands-on lab

Duration: 30 minutes

In this lab, you will create a developer environment and download the required files for this course if you do not already have one that meets the requirements.

### Prerequisites

-   Microsoft Azure subscription <http://azure.microsoft.com/en-us/pricing/free-trial/>

-   Client computer with Windows 7 or later with Visual Studio Code and Git installed

>NOTE: If you meet both of the above requirements, skip to Task 2 below.

### Task 1: Use Azure Shell as your development environment

>NOTE: This task is for students that do not have a client computer with Visual Studio Code and Git installed or would rather not put lab files on a personal device. This workshop can be completed using only the Azure Cloud Shell. Perform the steps below if you are limited to using the Azure Cloud Shell. If you do have a client computer with Visual Studio code and Git installed, skip to the next task.

1.  From the Azure web portal, launch the **Azure Cloud Shell**. It has common Azure tools preinstalled and configured to use with your account.

    ![This is a screenshot of a icon used to launch the Azure Cloud Shell from the Azure Portal.](images/Setup/image3.png "Azure Cloud Shell launch icon")

2.  From inside the Azure Cloud Shell type these commands to configure Git:

    ```
    git config --global user.name "<your name>"
    git config --global user.email <your email>
    ```

### Task 2: Download the exercise files

1.  Download the exercise files for the training. Start by creating a new folder to place the files.

2.  Download the support files (.zip format), https://cloudworkshop.blob.core.windows.net/agile-continous-delivery/studentfiles.zip to the new folder. If you are using the Azure Cloud Shell, you can download the file by executing the following command inside the Cloud Shell window (all on one line):

    ```
    curl -o studentfiles.zip https://cloudworkshop.blob.core.windows.net/agile-continous-delivery/studentfiles.zip
    ```

3.  Extract the contents of the file to the new folder. If you are using the Azure Cloud Shell, you can execute the following command inside the Cloud Shell window:

    ```bash
    unzip studentfiles.zip
    ```

4. When unzipped, there will be two new folders named **arm** and **tailspintoysweb**. The workshop will refer to these folders throughout the exercises.
