library(dplyr)
#0. Reading and preparation test and train sets

filename <- "DS3.zip"

# Checking if zip-file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if un-zipped folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Read features from features.txt - used for names of column
features<-read.csv(".\\UCI HAR Dataset\\features.txt", sep=" ", header = FALSE, 
                   col.names = c("n","functions"))

#read activities from activity_labels.txt - used for activity names
activities<-read.csv(".\\UCI HAR Dataset\\activity_labels.txt", sep=" ", header = FALSE,
                   col.names = c("code", "activity"))

#read test set from x_test.txt based on column width(16) and used column names from features
test_set<-read.fwf(".\\UCI HAR Dataset\\test\\X_test.txt", widths = rep(16, each=NROW(features)), 
                   col.names = features$functions)

#read test set activities from y_test.txt 
test_set_activities<-read.csv(".\\UCI HAR Dataset\\test\\y_test.txt", header=FALSE, 
                              col.names = "code")

#read test set subject from subject_test.txt 
test_set_subject<-read.csv(".\\UCI HAR Dataset\\test\\subject_test.txt", header=FALSE, 
                              col.names = "subject")

#Combine columns in one test_set from test_set_subject, test_set_activities and test_set
test_set<-cbind(test_set_subject, test_set_activities, test_set)


#read train set from x_train.txt based on column width(16) and used column names from features
train_set<-read.fwf(".\\UCI HAR Dataset\\train\\X_train.txt", widths = rep(16, each=NROW(features)),
                    col.names = features$functions)

#read train set activities from y_train.txt 
train_set_activities<-read.csv(".\\UCI HAR Dataset\\train\\y_train.txt", header=FALSE, 
                              col.names = "code")

#read train set subject from subject_train.txt 
train_set_subject<-read.csv(".\\UCI HAR Dataset\\train\\subject_train.txt", header=FALSE, 
                           col.names = "subject")

#Combine columns in one train_set from train_set_subject, train_set_activities and train_set
train_set<-cbind(train_set_subject, train_set_activities, train_set)


#1.Merges the training and the test sets to create one data set.
df_set<-rbind(train_set, test_set)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
df_set_extract <- select(df_set, subject, code, contains("mean"), contains("std"))

#3.Uses descriptive activity names to name the activities in the data set
df_set$code <- activities[df_set$code, "activity"]

#4.Appropriately labels the data set with descriptive variable names. 
names(df_set)[2] = "activity"
names(df_set)<-gsub("Acc", "Accelerometer", names(df_set))
names(df_set)<-gsub("Gyro", "Gyroscope", names(df_set))
names(df_set)<-gsub("BodyBody", "Body", names(df_set))
names(df_set)<-gsub("Mag", "Magnitude", names(df_set))
names(df_set)<-gsub("^t", "Time", names(df_set))
names(df_set)<-gsub("^f", "Frequency", names(df_set))
names(df_set)<-gsub("tBody", "TimeBody", names(df_set))
names(df_set)<-gsub("-mean()", "Mean", names(df_set), ignore.case = TRUE)
names(df_set)<-gsub("-std()", "STD", names(df_set), ignore.case = TRUE)
names(df_set)<-gsub("-freq()", "Frequency", names(df_set), ignore.case = TRUE)
names(df_set)<-gsub("angle", "Angle", names(df_set))
names(df_set)<-gsub("gravity", "Gravity", names(df_set))

#5.From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
df_set_summary <- summarise_all(group_by(df_set, subject, activity), funs(mean))

write.table(df_set_summary, "Summary.txt", row.name=FALSE)