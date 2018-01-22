==================================================================
Coursera Week 3 Assignment 
==================================================================
jacksonSox

==================================================================

Utilized experimental data generated as described in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  The data is available https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

For this work, I associated the Samsung data points for each activity, labeled "activity" for each subject, labeled as "subjectNumber", participating in the activity.

From the experimental data obtained, I extracted the activity and subject information for each experiment.  Then the averages and standard deviation information was extracted.  The extracted data is labeled "class3TidyData.txt".  Then the averages grouped by the activity and subject level for all trials were aggregated and saved in "class3AggregateTidyData.txt" 

The dataset includes the following files:
=========================================

- 'README.txt'

- 'class3Week4FinalAssign.R': R scripts used to complete the data merge, cleaning, and aggregation.

- 'data': folder containing all the output data and input from the initial study

  - 'class3TidyData.txt' - script output containing the needed tidy data with activity, subjectNumber, mean, and standard deviation data from the train and test set.

  - 'class3AggregateTidyData.txt' - script output for the aggregated mean information grouped by activity and subject.

  - 'Assignment' - contains all input data needed from the original experimentation