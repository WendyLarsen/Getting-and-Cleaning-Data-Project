#Create one R script called run_analysis.R is created and does the following:

#1)Merges the training and the test sets to create one data set.
#2)Extracts only the measurements on the mean and standard deviation 
#for each measurement.
#3)Uses descriptive activity names to name the activities in the data set
#4)Appropriately labels the data set with descriptive variable names.
#5)From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.

#BEGIN BY DOWNLOADING DATA
#Here is the code used to download the data

install.packages("data.table")
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
     download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
     unzip("UCI HAR Dataset.zip", exdir = getwd())
    }

#THEN READ AND CONVERT THE DATA
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_y <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

data_train <-  data.frame(train_subject, train_y, train_x)
names(data_train) <- c(c('subject', 'activity'), features)

test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_y <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

data_test <-  data.frame(test_subject, test_y, test_x)
names(data_test) <- c(c('subject', 'activity'), features)

#1)MERGE THE TRAINING AND TEST DATA INTO ONE DATA SET
data_all <- rbind(data_train, data_test)


#2)EXTRACT THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
mean_std <- grep('mean|std', features)
data_sub <- data_all[,c(1,2,mean_std + 2)]


#3)USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITY IN THE DATA SET
labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
labels <- as.character(labels[,2])
data_sub$activity <- labels[data_sub$activity]


#4)LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
newname <- names(data_sub)
newname <- gsub("[(][)]", "", newname)
newname <- gsub("^t", "TimeDomain_", newname)
newname <- gsub("^f", "FrequencyDomain_", newname)
newname <- gsub("Acc", "Accelerometer", newname)
newname <- gsub("Gyro", "Gyroscope", newname)
newname <- gsub("Mag", "Magnitude", newname)
newname <- gsub("-mean-", ".Mean", newname)
newname <- gsub("-std-", ".StandardDeviation", newname)
newname <- gsub("-", "_", newname)
names(data_sub) <- newname 


#5)FROM STEPS 4, CREATE A SECOND INDEPENDENT TIDY DATA SET WITH THE AVERAGE 
#OF EACH VARIABLE FOR EACH ACTIVITY AND SUBJECT
tidy_data <- aggregate(data_sub[,3:81], 
     by = list(activity = data_sub$activity, 
     subject = data_sub$subject),
     FUN = mean)
write.table(x = tidy_data, 
     file = "tidy_data.txt", 
     row.names = FALSE)

#END