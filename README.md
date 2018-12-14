The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

Submission Requirements:
1) The submitted data set is tidy.
2) The Github repo contains the required scripts.
3) GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.
1)Merges the training and the test sets to create one data set.
2)Extracts only the measurements on the mean and standard deviation for each measurement.
3)Uses descriptive activity names to name the activities in the data set
4)Appropriately labels the data set with descriptive variable names.
5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R
1) It downloads the UCI HAR Dataset data set and puts the zip file working directrory. After it is downloaded, it unzips the file into the UCI HAR Dataset folder.
2) It then reads and converts the data
3) It then merges the training and test data into one data set (ie. use rbind)
4) It then extracts the mean and standard deviation for each measurement
5) It then cleans up the names 
6) Final step is to output it (write.table) to a clean data set called tidy_data.txt