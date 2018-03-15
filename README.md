# cleaningdataassignment
Contains the files for the 'Getting and Cleaning Data' Course Project

Step 1: Download the .zip file from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Step 2: Extract the files to the working directory.

A subdirectory, UCI HAR Dataset, will be created, with the following files.

UCI HAR Dataset\test\subject_test.txt 
Single column dataset
2947 rows: Each row has 1 of 9 possible values that identifies the subject

UCI HAR Dataset\test\y_test.txt 
Single column dataset
2947 rows: Each row has 1 of 6 possible values that identifies the activity

UCI HAR Dataset\test\X_test.txt 
561 columns 
2947 rows: Each row corresponds to the activity in y_test.txt

UCI HAR Dataset\test\Inertial Signals
Subdirectory containing 9 files. These files are not used.

UCI HAR Dataset\train\subject_train.txt 
Single column dataset
2947 rows: Each row has 1 of 9 possible values that identifies the subject

UCI HAR Dataset\train\y_train.txt 
Single column dataset
2947 rows: Each row has 1 of 6 possible values that identifies the activity

UCI HAR Dataset\train\X_train.txt 
561 columns 
2947 rows: Each row corresponds to the activity in y_train.txt

The column names for each column in X_test.txt and X_train.txt are listed in 
UCI HAR Dataset\features.txt

The activity labels for the 6 different kinds of activities are listed in 
UCI HAR Dataset\activity_labels.txt

UCI HAR Dataset\train\Inertial Signals
Subdirectory containing 9 files. These files are not used.

Step 3: Copy the script run_analysis.R to the working directory.

Step 4: Install the package dplyr, if it is not already installed.

Step 5: Run the script run_analysis.R in the working directory.
It will create an output file output.txt in the working directory.
output.txt contains the tidy data set with the average of each variable for each activity and each subject.
