# DCProject
Data Cleansing Project

This repository contains the run_analysis.R script and the two output files generated in the current working directory: 
1. merged_data.txt: 10299*68 dimension - for Step 4
2. tidy.txt: 180*68 dimension - for Step 5.

The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data:
i.Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in trainData, trainLabel and trainSubject variables respectively.

Step 1. Merges the training and the test sets to create one data set.
Read X_train.txt and X_test.txt in trainData and testData. Concatenate testData to trainData to generate a 10299x561 data frame:joinData.
Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Read the features.txt file and store the data in a variable called features. We only extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of joinData with the 66 corresponding columns.
Step 3. Uses descriptive activity names to name the activities in the data set
Read the activity_labels.txt file and store the data in a variable called activity.
Read y_train.txt and y_test.txt in trainLabel and testLabel. Concatenate them to generate joinLable. 
Transform the values of joinLabel according to the activity data frame.
Step 4. Appropriately labels the data set with descriptive variable names. 
Read subject_train and subject_test.txt in trainSubject and testSubject. Concatenate them to generate joinSubject. 
Combine the joinSubject, joinLabel and joinData by column to get a new cleaned 10299x68 data frame, cleanedData. Properly name the first two columns, "subject" and "activity". 
Write the result out to "merged_data.txt" file in current working directory. 
Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Write the result out to "tidy.txt" file in current working directory. 

