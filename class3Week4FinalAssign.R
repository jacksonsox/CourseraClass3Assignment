## This project uses experimental data from Samsung
## testing.
## Add in the subjects to the test/train data
## merge the test and train data files (total data)
## add column headings to the total data set
## extrct the average and std variables
## add activity text to the activity files
## merge the activity files
## merge the actity files and the data files
## group by activity and subject
## average the means for activity/subject combinations

## set up the environment
setwd("~/Documents/Development/Coursera/Class 3/Assignment")

dataAssignmentsDir <- "./data/Assignment"
if (!file.exists(dataAssignmentsDir)) {
    dir.create(dataAssignmentsDir)
}

# 1. Merges the training and the test sets to create one data set.

## get the data sets
trainFile <- paste0(dataAssignmentsDir, "/X_train.txt")
testFile <- paste0(dataAssignmentsDir, "/X_test.txt")

train_DF <- read.table(trainFile)
test_DF <- read.table(testFile)

## get the subject sets
trainSubjectFile <- paste0(dataAssignmentsDir, "/subject_train.txt")
testSubjectFile <- paste0(dataAssignmentsDir, "/subject_test.txt")

trainSubject_DF <- read.table(trainSubjectFile)
testSubject_DF <- read.table(testSubjectFile)

## bind the subject to the data
subTrain_DF <- cbind(trainSubject_DF, train_DF)
subTest_DF <- cbind(testSubject_DF, test_DF)

## merget the subject/data set
total_DF <- rbind(subTrain_DF, subTest_DF)

# get the feature heading
featureHeadingFile <- paste0(dataAssignmentsDir, "/features.txt")
featureHeading_DF <- read.table(featureHeadingFile)
featureHeadingVector <- as.character(featureHeading_DF[, 2])

## include subject Number
featureHeadingVectorSub <- c("subjectNumber", featureHeadingVector)

## label the subject/data file
colnames(total_DF) <- featureHeadingVectorSub

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
featuresMeanStdev_DF <- total_DF[ , grep(("subjectNumber|-mean()|-std()"), names(total_DF))]

# 3. Uses descriptive activity names to name the activities in the data set
testActFile <- paste0(dataAssignmentsDir, "/y_test.txt")
trainActFile <- paste0(dataAssignmentsDir, "/y_train.txt")
activitiesLabelFile <- paste0(dataAssignmentsDir, "/activity_labels.txt")

trainAct_DF <- read.table(trainActFile)
testAct_DF <- read.table(testActFile)
activitiesLabel_DF <- read.table(activitiesLabelFile)

## combine the activty files
totalAct_DF <- rbind(trainAct_DF, testAct_DF)

## merge in the labels for the activity
totalActLabel_DF <- merge(totalAct_DF, activitiesLabel_DF)

# 4. Appropriately labels the data set with descriptive variable names.
labeledFeaturesMeanStdev_DF <- cbind(totalActLabel_DF, featuresMeanStdev_DF)
colnames(labeledFeaturesMeanStdev_DF)[1] <- "activityNumber"
colnames(labeledFeaturesMeanStdev_DF)[2] <- "activity"

## drop the activity number as it is no longer needed
finalLabeledFeaturesMeanStdev_DF <- labeledFeaturesMeanStdev_DF[, !(colnames(labeledFeaturesMeanStdev_DF) %in% c("activityNumber"))]

## write out the tidy data
tidyDataFileName <- paste0("./data", "/class3TidyData.txt")
write.table(finalLabeledFeaturesMeanStdev_DF, tidyDataFileName, row.names = FALSE)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
if (!require(dplyr)) {
    install.packages("dplyr")
}
library(dplyr)

## get the average values for the activity/subjects
featuresMean_DF <- finalLabeledFeaturesMeanStdev_DF[ , grep(("activity|subjectNumber|-mean()"), names(finalLabeledFeaturesMeanStdev_DF))]

## aggregate over the averages and order by activity and subject
allAverage_DF <- aggregate( featuresMean_DF[,3:48], featuresMean_DF[,1:2], FUN = mean )
allAverageOrdered_DF <- allAverage_DF[with(allAverage_DF, order(activity, subjectNumber)), ]

## write out the aggregate tidy data
tidyDataAggregateFileName <- paste0("./data", "/class3AggregateTidyData.txt")
write.table(allAverageOrdered_DF, tidyDataAggregateFileName, row.names = FALSE)