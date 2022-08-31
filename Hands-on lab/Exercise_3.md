# Exercise 3: Explore GitHub advance security features 

Duration 60 minutes

Once the Fabrikamk Medical Conferences developer workflow has been deployed, we can apply the github advance security features.

## Task 1:
**Help references**



## Task 2: Enabling Github Dependabot 

## Task 3: Enabling Codescanning and CodeQL alerts 

What is codescanning? 
Code scanning is a feature that you use to analyze the code in a GitHub repository to find security vulnerabilities and coding errors. Any problems identified by the analysis are shown in GitHub.

1. Make sure your repository is public

   **Note:** If the repository visibility is private, go to the settings of the repository and change the visibility to public.
   
1. Go to seetings tab of the repository, then under security tab select code security and analysis.


   ![](media/imgcs.png)
   

1. Then you will reach into Codescanning pane under security tab, click on configure codeQL alerts.


   ![](media/imgcs1.png)
   
  
1. It will generate a workflow codeql-analysis.yml. Review the yml file, you can find how many languages supported by codeQL and click on Start Commit, then click on      commit new file
  
  
  ![](media/imgcs3.png)
  
  
  
  **Note:** For most projects, this workflow file will not need changing; you simply need to commit it to your repository. You may wish to alter this file to             override the set of languages analyzed or to provide custom queries or build logic.
  
  Under Actions tab you can see the workflow committed successfully.
  
  ![](image/imgcs4.png)
  
1. Go to Codescanning under security tab you can see code scanning alerts enabled.
   
   ![](image/imgcs5.png)
  
  

    
