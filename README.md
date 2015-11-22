# Human-Activity-Recognition-Using-Smartphones

This repository contains a R script called run_analysis.R that does the following

1- Merges the training and the test sets to create one data set.
2- Extracts only the measurements on the mean and standard deviation for each measurement. 
3- Uses descriptive activity names to name the activities in the data set
4- Appropriately labels the data set with descriptive variable names. 
5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The first part of the script is reading the zip file from the given url and unzipping the file. 
all the required input files are read via the read.table function.

Using rbind function which merges rows within data sets, we merge the training and the test sets to create one data set. 

To extract only the columns that contain the words "mean" or "std" in their headings, we use the grep function and find those columns in the input data set "features". We use this subset of "features" to create a new data set "mean_std_Data" which only contains columns which have the words "mean" or "std" in their headings.

In the next section, we add 2 more columns (Activity, Subject) to the merged (X_test, X_train) data set.  We also replace the Activity number by the activity_labels.

At the end we use the melt and dcast functions to group by the data set by Activity and Subject, and use the mean function to apply to the rest of the columns per each group. We output the result in Tidy_Data.txt file.
