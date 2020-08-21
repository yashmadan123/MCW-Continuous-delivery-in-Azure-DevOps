## Exercise 5: Trigger a build and release

Duration: 10 Minutes

In this exercise, you will trigger an automated build and release of the web application using the build and release pipelines you created in earlier exercises. The release pipeline will deploy to three stages: dev, test, and production.

Any commit to the master branch will automatically trigger a build, but you can man manually trigger, or queue a build without a code change.

### Task 1: Manually queue a new build and follow it through the release pipeline

1. To manually queue a build, select **Pipelines** from left navigation and choose your *TailspinToys* pipeline to view recent runs and select the  **Run pipeline** button in the upper right corner to queue the build:

    ![Screen showing pipeline runs with Run Pipeline button highlighted.](images/stepbystep/media/image1033.png "Pipeline Runs-Manual Queue")


2. This action shows the **Run pipeline** view. Select **Run** at the bottom of the modal window to queue a manual build. 

    ![Screen showing Run Pipeline panel with Run button highlighted.](images/stepbystep/media/image1034.png "Run Pipeline")


3. Because you configured continuous deployment using the Unified YAML approach you get a full execution from dev, through test, to production. Let's verify the run by selecting the manual run and viewing the details:

    ![On the screen, the manual run has successfully completed. Each stage has a green checkmark.](images/stepbystep/media/image1035.png "Pipeline Run Details")


