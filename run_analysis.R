#fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Read the column names of xdata from features.txt 
# Initialize the column names in the dataframe xdata using those names
fileName <- "UCI HAR Dataset\\features.txt"
columnnames <- read.delim(fileName, header=FALSE, sep = ' ')

for (whatdata in c('test', 'train')){
    
    my_dir <- paste("UCI HAR Dataset\\", whatdata, sep = "")
    fileName <- paste(my_dir, "\\subject_", whatdata, ".txt", sep = "")
    subjectData <- read.delim(fileName, header=FALSE, sep = ' ')
    fileName <- paste(my_dir, "\\X_", whatdata, ".txt", sep = "")
    xdata <- read.fwf(fileName, c(rep(16, 561)), header = FALSE)
    fileName <- paste(my_dir, "\\y_", whatdata, ".txt", sep = "")
    ydata <- read.delim(fileName, header=FALSE, sep = ' ')

    # Labelling the data set with descriptive variable names.
    colnames(subjectData)[1] <- "subjectid"
    colnames(ydata)[1] <- "activityid"
    
    # Initialize the column names in the dataframe xdata using the names read from features.txt
    # Labels the data set with descriptive variable names.
    names(xdata) <- columnnames$V2
    
    # Create a data frame with the necessary columns from all three data frames
    if (whatdata == 'test')
        testdata <- cbind(xdata, cbind(subjectData, ydata))
    else
        traindata <- cbind(xdata, cbind(subjectData, ydata))
    
}

# Merge the testing and training data to create one data set
mergeddata <- rbind(testdata, traindata)

# Extracting the mean and standard deviation columns from the merged data 
extracteddata <- mergeddata[ ,c("tBodyAcc-mean()-X", 
                           "tBodyAcc-mean()-Y", 
                           "tBodyAcc-mean()-Z", 
                           "tBodyAcc-std()-X", 
                           "tBodyAcc-std()-Y", 
                           "tBodyAcc-std()-Z", 
                           "tGravityAcc-mean()-X", 
                           "tGravityAcc-mean()-Y", 
                           "tGravityAcc-mean()-Z", 
                           "tGravityAcc-std()-X", 
                           "tGravityAcc-std()-Y", 
                           "tGravityAcc-std()-Z", 
                           "tBodyAccJerk-mean()-X", 
                           "tBodyAccJerk-mean()-Y", 
                           "tBodyAccJerk-mean()-Z", 
                           "tBodyAccJerk-std()-X", 
                           "tBodyAccJerk-std()-Y", 
                           "tBodyAccJerk-std()-Z", 
                           "tBodyGyro-mean()-X", 
                           "tBodyGyro-mean()-Y", 
                           "tBodyGyro-mean()-Z", 
                           "tBodyGyro-std()-X", 
                           "tBodyGyro-std()-Y", 
                           "tBodyGyro-std()-Z", 
                           "tBodyGyroJerk-mean()-X", 
                           "tBodyGyroJerk-mean()-Y", 
                           "tBodyGyroJerk-mean()-Z", 
                           "tBodyGyroJerk-std()-X", 
                           "tBodyGyroJerk-std()-Y", 
                           "tBodyGyroJerk-std()-Z", 
                           "tBodyAccMag-mean()", 
                           "tBodyAccMag-std()", 
                           "tGravityAccMag-mean()", 
                           "tGravityAccMag-std()", 
                           "tBodyAccJerkMag-mean()", 
                           "tBodyAccJerkMag-std()", 
                           "tBodyGyroMag-mean()", 
                           "tBodyGyroMag-std()", 
                           "tBodyGyroJerkMag-mean()", 
                           "tBodyGyroJerkMag-std()", 
                           "fBodyAcc-mean()-X", 
                           "fBodyAcc-mean()-Y", 
                           "fBodyAcc-mean()-Z", 
                           "fBodyAcc-std()-X", 
                           "fBodyAcc-std()-Y", 
                           "fBodyAcc-std()-Z", 
                           "fBodyAcc-meanFreq()-X", 
                           "fBodyAcc-meanFreq()-Y", 
                           "fBodyAcc-meanFreq()-Z", 
                           "fBodyAccJerk-mean()-X", 
                           "fBodyAccJerk-mean()-Y", 
                           "fBodyAccJerk-mean()-Z", 
                           "fBodyAccJerk-std()-X", 
                           "fBodyAccJerk-std()-Y", 
                           "fBodyAccJerk-std()-Z", 
                           "fBodyGyro-mean()-X", 
                           "fBodyGyro-mean()-Y", 
                           "fBodyGyro-mean()-Z", 
                           "fBodyGyro-std()-X", 
                           "fBodyGyro-std()-Y", 
                           "fBodyGyro-std()-Z", 
                           "fBodyAccMag-mean()", 
                           "fBodyAccMag-std()", 
                           "fBodyBodyAccJerkMag-mean()", 
                           "fBodyBodyAccJerkMag-std()", 
                           "fBodyBodyGyroMag-mean()", 
                           "fBodyBodyGyroMag-std()", 
                           "fBodyBodyGyroJerkMag-mean()", 
                           "fBodyBodyGyroJerkMag-std()",
                           "subjectid",
                           "activityid"
)]

fileName <- "UCI HAR Dataset\\activity_labels.txt"
activities <- read.delim(fileName, header=FALSE, sep = ' ')
colnames(activities)[1] <- 'activityid'
colnames(activities)[2] <- 'activitylabel'

# Added a descriptive activity labels column to name the activities in the data set
extracteddata$activitylabel <- activities$activitylabel[match(extracteddata$activityid, activities$activityid)]
names(extracteddata) = tolower(names(extracteddata))

# Creates an independent tidy data set with the average of each variable for each activity and each subject
library(dplyr)
meansdata <- extracteddata %>% group_by(subjectid, activityid, activitylabel) %>% summarise_all(funs(mean))

write.table(meansdata, file = "output.txt", row.names = FALSE)
