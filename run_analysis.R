setwd("~Documents/Coursera Data Science/Course 3/UCI HAR Dataset")
data_dir <- "~Documents/Coursera Data Science/Course 3/UCI HAR Dataset"
ActivityTest  <- read.table(file.path(data_dir, "y_test.txt" ), header = FALSE)
ActivityTrain <- read.table(file.path(data_dir, "y_train.txt"), header = FALSE)
SubjectTrain <- read.table(file.path(data_dir, "subject_train.txt"), header = FALSE)
SubjectTest  <- read.table(file.path(data_dir, "subject_test.txt"), header = FALSE)
FeaturesTest  <- read.table(file.path(data_dir, "X_test.txt" ), header = FALSE)
FeaturesTrain <- read.table(file.path(data_dir, "X_train.txt"), header = FALSE)
Subject <- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(data_dir, "features.txt"), header = FALSE)
names(Features)<- FeaturesNames$V2
Merge <- cbind(Subject, Activity)
Everything <- cbind(Features, Merge)
Subset_FeaturesNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
Add_Names <- c(as.character(Subset_FeaturesNames), "subject", "activity" )
Everything <- subset(Everything, select = Add_Names)
Everything$activity <- as.character(Everything$activity)
Everything$activity[Everything$activities == 1] <- "Walking"
Everything$activity[Everything$activities == 2] <- "Walking Upstairs"
Everything$activity[Everything$activities == 3] <- "Walking Downstairs"
Everything$activity[Everything$activities == 4] <- "Sitting"
Everything$activity[Everything$activities == 5] <- "Standing"
Everything$activity[Everything$activities == 6] <- "Laying"
Everything$activities <- as.factor(Everything$activities)
names(Everything) <- gsub("^t", "time", names(Data))
names(Everything) <- gsub("^f", "frequency", names(Data))
names(Everything) <- gsub("Acc", "Accelerometer", names(Data))
names(Everything) <- gsub("Gyro", "Gyroscope", names(Data))
names(Everything) <- gsub("Mag", "Magnitude", names(Data))
names(Everything) <- gsub("BodyBody", "Body", names(Data))
library(plyr)
Everything_Mean <- aggregate(. ~subject + activity, Everything, mean)
Everything_Mean <- Everything_Mean[order(Everything_Mean$subject, Everything_Mean$activity),]
write.table(Everything_Mean, file = "Average_tidy_data.txt", row.name=FALSE)
