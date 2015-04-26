## Getting and Cleaning Data Course Project ##

### Introduction ###


The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

One of the most exciting areas in all of data science right now is wearable computing ­ see for example this article
([http://www.insideactivitytracking.com/data­science­activity­tracking­and­the­battle­for­the­worlds­top­sports­brand/](http://www.insideactivitytracking.com/data­science­activity­tracking­and­the­battle­for­the­worlds­top­sports­brand/)). 

Companies like Fitbit, Nike and  Jawbone Up are racing to develop the most advanced algorithms to attract new users. 

A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


    
**The data for the project:**

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


**Project Files**
 

1. run_analysis.R: the code run over the data set
2. README.md: this project file 
3. tidydataset.txt: the data extracted from the original data (UCI HAR Dataset.zip). 
4. CodeBook.md: CodeBook that describes data file tidydataset.txt. 

<br>

### Libraries Used ###

>```
>
>library(data.table)
>
>library(dplyr)
>
>library(plyr)
>
>library(downloader)

>```

<br>

### Get the data ###

>```
>
>
>
>download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI HAR Dataset.zip", mode = "wb")

>
>
>file_zip <- "UCI HAR Dataset.zip"

>
>
>directory_file <- "./UCI HAR Dataset"

>
>
if (file.exists(directory_file) == FALSE) {
    unzip(file_zip)
}

>```

<br>

###Merges the training and the test sets to create one data set.

**Read test data set**

>```
>


>features_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
>
>activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
>  
>subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)


>```

**Read train data set**
>```
>

>
>features_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)

>activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

>subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

>```


**#  Merge the training and the test sets to create one data set**
>```

>features <- rbind(features_train, features_test)
>
>activity <- rbind(activity_train, activity_test)
>
subject <- rbind(subject_train, subject_test)

>```

**# creates one data set**
>```
>
features_names <- read.table("UCI HAR Dataset/features.txt")


>
colnames(features) <- t(features_names[2])

>colnames(activity) <- "Activity"
>
colnames(subject) <- "Subject"


>
all_data <- cbind(features,activity,subject)


>```


<br>

###Extracts only the measurements on the mean and standard deviation for each measurement###

  Features with mean() and std() and include entries with mean in an earlier part of the name.
  Decision-making criteria was based on the articles:

  Anguita, D., Ghio, A., Oneto, L., Parra, X., & Reyes-Ortiz, J. L. (2013). 
  A public domain dataset for human activity recognition using smartphones. In European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN.

  Su, X., Tong, H., & Ji, P. (2014). Activity recognition with smartphone sensors. 
  Tsinghua Science and Technology, 19(3), 235-249.


>```
>
>features_mean_std <- grep(".*Mean.*|.*Std.*", names(all_data), ignore.case=TRUE)
>
>
selected_columns <- c(features_mean_std, 562, 563)
>
data_extracted <- all_data[,selected_columns]

>```

<br>

### Uses descriptive activity names to name the activities in the data set

>```
>
>activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
>
data_extracted$Activity <- as.character(data_extracted$Activity)
>
for (i in 1:6) {
    data_extracted$Activity[data_extracted$Activity == i] <- as.character(activity_labels[i,2])
>
}
>
>```

<br>

###  Appropriately labels the data set with descriptive variable names

>```
>
>names(data_extracted) <- gsub("^t", "time", names(data_extracted))
>
>names(data_extracted) <- gsub("^f", "frequency", names(data_extracted))
>
>names(data_extracted) <- gsub("Acc", "Accelerometer", names(data_extracted))
>
>names(data_extracted) <- gsub("Gyro", "Gyroscope", names(data_extracted))
>
>names(data_extracted) <- gsub("Mag", "Magnitude", names(data_extracted))
>
>names(data_extracted) <- gsub("BodyBody", "Body", names(data_extracted))
>
>names(data_extracted)  <-gsub("angle", "Angle", names(data_extracted))
>
>names(data_extracted)  <-gsub("gravity", "Gravity", names(data_extracted))
>
>names(data_extracted)  <-gsub("tBody", "TimeBody", names(data_extracted))
>
>names(data_extracted)  <-gsub("-mean()", "Mean", names(data_extracted), ignore.case = TRUE)
>
>names(data_extracted)  <-gsub("-std()", "STD", names(data_extracted), ignore.case = TRUE)
>
>names(data_extracted)  <-gsub("-freq()", "Frequency", names(data_extracted), ignore.case = TRUE)
>
>```

<br>

###  From the data set in step 4, creates a second, independent tidy data set with the average of each variable and for each activity and each subject

>```
>
>data_extracted$Subject <- as.factor(data_extracted$Subject)
>
>data_extracted <- data.table(data_extracted)
>
>second_data = ddply(data_extracted, c("Activity","Subject"), numcolwise(mean))
>
>write.table(second_data, file = "tidydataset.txt", row.name=FALSE)
>```

<br>


**The result is saved as tidydataset.txt.**