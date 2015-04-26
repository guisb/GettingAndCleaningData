## CodeBook ##

Describes data file **tidydataset.txt.** 


### Data Set ###

**Human Activity Recognition Using Smartphones Data Set**

Data was obtained at the site: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


###Data Set Information:###

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


###Attribute Information:###


For each record in the dataset it is provided:


- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


###Data Input:###

- X_train.txt: Training set.
- y_train.txt: Training labels.
- X_test.txt: Test set.
- y_test.txt: Test labels.
- activity_labels.txt: Links the class labels with their activity name.
- features.txt': List of all features.
- train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- test/Subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 24.


###Data Transformations:###



- X\_test.txt: to features\_test.
- y\_test.txt: to  activity\_test.
- subject\_test.txt: to  subject\_test.
- X\_train.txt:  to  features\_train.
- y\_train.txt:  to  activity\_train.
- subject\_train.txt:  to  subject\_train.
- features.txt: to  feature\_names.
- activity\_labels.txt: to  activityLabels.
- features: merge from data.frames features\_train and features\_test.
- activity: merge from data.frames activity\_train and activity\_test.
- subject: merge from data.frames subject\_train and subject\_test.
- all\_data: from data.frames features, activity and subject.
- data\_extracted: the measurements on the mean and standard deviation for each measurement.
- data\_extracted (Activity column): updated with names of activities.
- data\_extracted (variable names): replaced with labels the data set with descriptive variable  names.
- tidydataset.txt: tidy data set created with the average of each variable for each activity and each subject (ordered by activity and subject).


###Tidy data set###

**tidydataset.txt** file was created with the average of each variable for each activity and each subject. It was ordered by activity and subject. 
 

