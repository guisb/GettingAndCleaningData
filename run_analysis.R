library(data.table)
library(dplyr)
library(plyr)
library(downloader)

# Get data
download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI HAR Dataset.zip", mode = "wb")

# Local file data
file_zip <- "UCI HAR Dataset.zip"

# Directory
directory_file <- "./UCI HAR Dataset"

# Unzip
if (file.exists(directory_file) == FALSE) {
    unzip(file_zip)
}

## Merges the training and the test sets to create one data set.

# read test data set
features_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)  
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)


# read train data set
features_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)


#  Merge the training and the test sets to create one data set

features <- rbind(features_train, features_test)
activity <- rbind(activity_train, activity_test)
subject <- rbind(subject_train, subject_test)


# read features names
features_names <- read.table("UCI HAR Dataset/features.txt")

# set columns names
colnames(features) <- t(features_names[2])
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"

# creates one data set
all_data <- cbind(features,activity,subject)


##  Extracts only the measurements on the mean and standard deviation for each measurement
#  Features with mean() and std() and include entries with mean in an earlier part of the name.
#
#  Decision-making criteria was based on the articles:
#
#  Anguita, D., Ghio, A., Oneto, L., Parra, X., & Reyes-Ortiz, J. L. (2013). 
#  A public domain dataset for human activity recognition using smartphones. In European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN.
#
#  Su, X., Tong, H., & Ji, P. (2014). Activity recognition with smartphone sensors. 
#  Tsinghua Science and Technology, 19(3), 235-249.

features_mean_std <- grep(".*Mean.*|.*Std.*", names(all_data), ignore.case=TRUE)

# add Activity and Subject to features with mean e std
selected_columns <- c(features_mean_std, 562, 563)

data_extracted <- all_data[,selected_columns]


## Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

data_extracted$Activity <- as.character(data_extracted$Activity)

for (i in 1:6) {
    data_extracted$Activity[data_extracted$Activity == i] <- as.character(activity_labels[i,2])
}


##  Appropriately labels the data set with descriptive variable names

names(data_extracted) <- gsub("^t", "time", names(data_extracted))
names(data_extracted) <- gsub("^f", "frequency", names(data_extracted))
names(data_extracted) <- gsub("Acc", "Accelerometer", names(data_extracted))
names(data_extracted) <- gsub("Gyro", "Gyroscope", names(data_extracted))
names(data_extracted) <- gsub("Mag", "Magnitude", names(data_extracted))
names(data_extracted) <- gsub("BodyBody", "Body", names(data_extracted))
names(data_extracted)  <-gsub("angle", "Angle", names(data_extracted))
names(data_extracted)  <-gsub("gravity", "Gravity", names(data_extracted))
names(data_extracted)  <-gsub("tBody", "TimeBody", names(data_extracted))
names(data_extracted)  <-gsub("-mean()", "Mean", names(data_extracted), ignore.case = TRUE)
names(data_extracted)  <-gsub("-std()", "STD", names(data_extracted), ignore.case = TRUE)
names(data_extracted)  <-gsub("-freq()", "Frequency", names(data_extracted), ignore.case = TRUE)

##  From the data set in step 4, creates a second, independent tidy data set with the average of each variable
##  for each activity and each subject

data_extracted$Subject <- as.factor(data_extracted$Subject)
data_extracted <- data.table(data_extracted)

second_data = ddply(data_extracted, c("Activity","Subject"), numcolwise(mean))
write.table(second_data, file = "tidydataset.txt", row.name=FALSE)
