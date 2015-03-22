# Course-3-Project
## First, set the directory containing the Samsung Galaxy II participant data files
setwd("~Documents/Coursera Data Science/Course 3/UCI HAR Dataset")

## Dedicate object containing a path to the directory which has the data files
data_dir <- "~Documents/Coursera Data Science/Course 3/UCI HAR Dataset"

## Read the files into the R Console and assign the files to objects
ActivityTest  <- read.table(file.path(data_dir, "y_test.txt" ), header = FALSE)
ActivityTrain <- read.table(file.path(data_dir, "y_train.txt"), header = FALSE)
SubjectTrain <- read.table(file.path(data_dir, "subject_train.txt"), header = FALSE)
SubjectTest  <- read.table(file.path(data_dir, "subject_test.txt"), header = FALSE)
FeaturesTest  <- read.table(file.path(data_dir, "X_test.txt" ), header = FALSE)
FeaturesTrain <- read.table(file.path(data_dir, "X_train.txt"), header = FALSE)

## 1.Merges the training and the test sets to create one data set.
## Per first requirement, merge the Test and Train data into one dataset
Subject <- rbind(SubjectTrain, SubjectTest)

Activity<- rbind(ActivityTrain, ActivityTest)

Features<- rbind(FeaturesTrain, FeaturesTest)

## Add headers to the columns for the Subject and Activity 
names(Subject)<-c("subject")

names(Activity)<- c("activity")

## Add column descriptions from the features file
FeaturesNames <- read.table(file.path(data_dir, "features.txt"), header = FALSE)

names(Features)<- FeaturesNames$V2

## Merge everything to one data frame
Merge <- cbind(Subject, Activity)

Everything <- cbind(Features, Merge)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## Per requirement 2, exclude the feature names that do not include the mean or standard deviation using regular ##expressions
Subset_FeaturesNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

## Update the merged data frame so that only the feature names that include mean and standard deviation are shown
Add_Names <- c(as.character(Subset_FeaturesNames), "subject", "activity" )

Everything <- subset(Everything, select = Add_Names)

## 3. Uses descriptive activity names to name the activities in the data set
## Based on the Activity Labels file, update the activity column in the data frame to reflect the corresponding ##activity based on the ID given
Everything$activity <- as.character(Everything$activity)
Everything$activity[Everything$activities == 1] <- "Walking"

Everything$activity[Everything$activities == 2] <- "Walking Upstairs"


Everything$activity[Everything$activities == 3] <- "Walking Downstairs"

Everything$activity[Everything$activities == 4] <- "Sitting"

Everything$activity[Everything$activities == 5] <- "Standing"

Everything$activity[Everything$activities == 6] <- "Laying"

Everything$activities <- as.factor(Everything$activities)

## 4. Appropriately labels the data set with descriptive variable names
## Using regular expressions, rename the column headers to make them more easy to identify

names(Everything) <- gsub("^t", "time", names(Data))

names(Everything) <- gsub("^f", "frequency", names(Data))

names(Everything) <- gsub("Acc", "Accelerometer", names(Data))

names(Everything) <- gsub("Gyro", "Gyroscope", names(Data))

names(Everything) <- gsub("Mag", "Magnitude", names(Data))

names(Everything) <- gsub("BodyBody", "Body", names(Data))

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for ##each activity and each subject.
## Using the "plyr" package in R, extract the mean of every column from the data frame and output to a text file
library(plyr)

Everything_Mean <- aggregate(. ~subject + activity, Everything, mean)

Everything_Mean <- Everything_Mean[order(Everything_Mean$subject, Everything_Mean$activity),]

write.table(Everything_Mean, file = "Average_tidy_data.txt", row.name=FALSE)
