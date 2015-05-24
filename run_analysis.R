
# Step1. Merges the training and the test sets to create one data set.

setwd("~/The Data Scientist's toolbox/Data cleansing/Project")

trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
dim(trainData) # [1] 7352  561
head(trainData)

testData <- read.table("UCI HAR Dataset/test/X_test.txt") 
dim(testData) # [1] 2947  561 

joinData <- rbind(trainData, testData) 
dim(joinData) # 10299*561 

# Step2. Extracts only the measurements on the mean and standard deviation for each measurement.  
features <- read.table("UCI HAR Dataset/features.txt")
dim(features)  # 561*2
#V1                  V2
#1   1   tBodyAcc-mean()-X
#2   2   tBodyAcc-mean()-Y
#3   3   tBodyAcc-mean()-Z
#4   4    tBodyAcc-std()-X
#5   5    tBodyAcc-std()-Y
#6   6    tBodyAcc-std()-Z

meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
# 1 2 3 4 5 6 41 ...
joinData <- joinData[, meanStdIndices]
#66 var
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # assign names and remove "()" 

# Step3. Uses descriptive activity names to name the activities in the data set 
activity <- read.table("UCI HAR Dataset/activity_labels.txt") 

#V1                 V2
#1  1            WALKING
#2  2   WALKING_UPSTAIRS
#3  3 WALKING_DOWNSTAIRS
#4  4            SITTING
#5  5           STANDING
#6  6             LAYING

activity[, 2] <- tolower(gsub("_", "", activity[, 2]))

trainLabel <- read.table("UCI HAR Dataset/train/y_train.txt")
table(trainLabel)
#1    2    3    4    5    6 
#1226 1073  986 1286 1374 1407
testLabel <- read.table("UCI HAR Dataset/test/y_test.txt")  
table(testLabel)  
#1   2   3   4   5   6 
#496 471 420 491 532 537 
joinLabel <- rbind(trainLabel, testLabel)
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step4. Appropriately labels the data set with descriptive activity names.  
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
joinSubject <- rbind(trainSubject, testSubject) 
dim(joinSubject) # 10299*1 

names(joinSubject) <- "subject" 
cleanedData <- cbind(joinSubject, joinLabel, joinData) 
dim(cleanedData) # 10299*68 

write.table(cleanedData, "merged_data.txt") 

# Step5. Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.  

currentActivity = 1 
for (currentActivityLabel in activity$V2) { 
    cleanedData$activity <- gsub(currentActivity, currentActivityLabel, cleanedData$activity) 
    currentActivity <- currentActivity + 1 
   } 
 

cleanedData$activity <- as.factor(cleanedData$activity) 
cleanedData$subject <- as.factor(cleanedData$subject) 

tidy = aggregate(cleanedData, by=list(activity = cleanedData$activity, subject=cleanedData$subject), mean) 
# Remove the subject and activity column, since a mean of those has no use 
tidy[,3] = NULL 
tidy[,3] = NULL 
write.table(tidy, "tidy.txt", sep="\t", row.name = FALSE) 

