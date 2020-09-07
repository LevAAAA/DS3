# 0. Reading and preparation test and train sets
>Dataset downloaded and extracted under the folder called UCI HAR Dataset

## Read features from features.txt - used for names of column
>features <- features.txt : 561 rows, 2 columns
>The features selected for this database come from the accelerometer and gyroscope

## Read activities from activity_labels.txt - used for activity names
>activities <- activity_labels.txt : 6 rows, 2 columns
>List of activities performed when the corresponding measurements were taken and its codes (labels)

## Read test set from x_test.txt based on column width(16) and used column names from features
>test_set <- test/X_test.txt : 2947 rows, 561 columns
>Contains recorded features test data

## Read test set activities from y_test.txt 
>test_set_activities <- test/y_test.txt : 2947 rows, 1 columns
>Contains test data of activities’code labels

## Read test set subject from subject_test.txt 
>test_set_subject <- test/subject_test.txt : 2947 rows, 1 column
>Contains test data of test subjects being observed

## Combine columns in one test_set from test_set_subject, test_set_activities and test_set
>test_set : 2947 rows, 563 columns
>Contains subjects, activities and recorded features test data - using cbind() function

## Read train set from x_train.txt based on column width(16) and used column names from features
>train_set <- test/X_train.txt : 7352 rows, 561 columns
>contains recorded features train data

## Read train set activities from y_train.txt 
>train_set_activities <- test/y_train.txt : 7352 rows, 1 column
>contains train data of activities’code labels

## Read train set subject from subject_train.txt 
>train_set_subject <- test/subject_train.txt : 7352 rows, 1 column
>contains train data subjects being observed

## Combine columns in one train_set from train_set_subject, train_set_activities and train_set
>train_set : 7352 rows, 561 columns
>Contains subjects, activities and recorded features train data - using cbind() function


# 1.Merges the training and the test sets to create one data set.
>df_set : 10299 rows, 563 columns 
>Is created by merging test_set and train_set using rbind() function

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
>df_set_extract : 10299 rows, 88 columns 
>Is created by subsetting df_set selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

# 3.Uses descriptive activity names to name the activities in the data set
>df_set 
>Numbers in code column of the df_set replaced with corresponding activity taken from second column of the activities variable

# 4.Appropriately labels the data set with descriptive variable names. 
>df_set
>code column in df_set renamed into activities
>All Acc in column’s name replaced by Accelerometer
>All Gyro in column’s name replaced by Gyroscope
>All BodyBody in column’s name replaced by Body
>All Mag in column’s name replaced by Magnitude
>All start with character t in column’s name replaced by Time
>All start with character f in column’s name replaced by Frequency
>All tBody in column’s name replaced by TimeBody
>All Mean in column’s name replaced by Mean
>All std in column’s name replaced by STD
>All freq in column’s name replaced by Frequency
>All angle in column’s name replaced by Angle
>All gravity in column’s name replaced by Gravity

# 5.From the data set in step 4, creates a second, independent tidy data set 
>df_set_summary : 180 rows, 563 columns
>Is created by sumarizing df_set taking the means of each variable for each activity and each subject, after groupped by subject and activity.
>
>Export df_set_summary into Summury.txt file.
