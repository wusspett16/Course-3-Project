# Getting and Cleaning Data Course Project CodeBook
This file contains an overview of the steps taken to organize the data taken from the Human Activity Recognition
Using Smartphones Data Set.

# Downloading and loading data

- Use link to download data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Reads the activity labels to activityLabels
- Reads the column names of data (a.k.a. features) to features
- Reads the test data.frame to testData
- Reads the trainning data.frame to trainningData

# Manipulating and cleaning data

1. Merges test data and trainning data to object Everything
2. Extracts the mean and std columns and adds subject and activity to the merged data
3. Names the activity ID's in the merged data (Everything) based on the activity labels file
4. Renames, where needed, column headers that are not immediately straight forward to make them easy to understand

At this point the final data frame meanAndStdAverages looks like this:
>head(Data[, 64:68], n=3)
  frequencyBodyGyroscopeMagnitude-std() frequencyBodyGyroscopeJerkMagnitude-mean() frequencyBodyGyroscopeJerkMagnitude-std() subject activity
1                            -0.9613094                                 -0.9919904                                -0.9906975       1 STANDING
2                            -0.9833219                                 -0.9958539                                -0.9963995       1 STANDING
3                            -0.9860277                                 -0.9950305                                -0.9951274       1 STANDING

#Writing final data to CSV

5. creates a text file containing the mean of all of the columns from the Everything data frame

Creates the output text file.
