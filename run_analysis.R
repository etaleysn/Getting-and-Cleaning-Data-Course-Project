library(plyr)

# Attempt to set working directory same as R script location
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)


## Download and unzip the dataset:

filename <- "ucihardataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[, 2] <- tolower(gsub("_", "", activityLabels[, 2]))

# camelCase column names
substr(activityLabels[2, 2], 8, 8) <- toupper(substr(activityLabels[2, 2], 8, 8)) 
substr(activityLabels[3, 2], 8, 8) <- toupper(substr(activityLabels[3, 2], 8, 8))


#Load features
features <- read.table("UCI HAR Dataset/features.txt")

# Extract only the data on mean and standard deviation
targetFeatures <- grep("mean\\(\\)|std\\(\\)", features[, 2])
targetFeatures.names <- features[targetFeatures,2]
targetFeatures.names = gsub('-mean', 'Mean', targetFeatures.names)
targetFeatures.names = gsub('-std', 'Std', targetFeatures.names)
targetFeatures.names <- gsub('[-()]', '', targetFeatures.names)

# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[targetFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[targetFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge datasets and add labels
mergedData <- rbind(train, test)
colnames(mergedData) <- c("subject", "activity", targetFeatures.names)

# Give activity descriptive label
descriptiveLabels <- activityLabels[mergedData[,2],2]
mergedData[, 2] <- descriptiveLabels


# Write out the merged dataset
write.table(mergedData, "mergedData.txt") 

# Compute means on columns 3 through 68
averagesData <- ddply(mergedData, .(subject, activity), function(x) colMeans(x[, 3:68]))

# Write out the averages dataset
write.table(averagesData, "averagesData.txt", row.name=FALSE)