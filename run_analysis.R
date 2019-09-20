#clear Environment
rm(list=ls())

#load packages
library(dplyr)

#download and unzip data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "data.zip")
unzip("/data.zip")

#load data in environment
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merge the training and the test sets to create one data set.
subject <- rbind(subjectTest, subjectTrain)
x <- rbind(xTest, xTrain)
y <- rbind(yTest, yTrain)

all <- cbind(subject, x, y)
xTest

#Extract only the measurements on the mean and standard deviation for each measurement.
clean <- all %>% select(subject, code, contains("mean"), contains("std"))

#Use descriptive activity names to name the activities in the data set
clean2 <- merge(activities, clean, by = "code")

#Appropriately label the data set with descriptive variable names.
names(clean2) <- gsub("Acc", ".accelerometer", names(clean2))
names(clean2) <- gsub("Gyro", ".gyroscope", names(clean2))
names(clean2) <- gsub("BodyBody", ".body", names(clean2))
names(clean2) <- gsub("Mag", ".magnitude", names(clean2))
names(clean2) <- gsub("^t", "time", names(clean2))
names(clean2) <- gsub("^f", "frequency", names(clean2))
names(clean2) <- gsub("timeBody", "time.body", names(clean2))
names(clean2) <- gsub("frequencyBody", "frequency.body", names(clean2))
names(clean2) <- gsub("timeGravity", "time.gravity", names(clean2))
names(clean2) <- gsub("-mean()", ".mean", names(clean2), ignore.case = TRUE)
names(clean2) <- gsub("-std()", ".std", names(clean2), ignore.case = TRUE)
names(clean2) <- gsub("-freq()", "frequency", names(clean2), ignore.case = TRUE)

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
average <- clean2 %>%  group_by(subject, activity) %>% summarise_all(funs(mean))

#Save final dataset
write.table(average, "finalDataset.txt", row.name=FALSE)