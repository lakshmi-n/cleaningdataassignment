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
extracteddata <- mergeddata[ , grepl("mean|std|subjectid|activityid", names(mergeddata))]

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
