##################################################
#### Getting and Cleaning Data Project ###########
Written by Jerry Currie 1/24/2015

##################################################
[Objective]
The goal of this project is to create a tidy dataset from raw, 
and aggregated accelerometer data collected by the
Smartlab company. This tidy data set will consist of
of accelerometer readings from 30 subjects
performing 6 different physical activities. The final
data set contains the average mean and average standard deviation
from preciously aggregated measurements of acceleration and 
angular velocity. The data was captured using a Samsung Galaxy S II 
smartphone. The final data set is grouped by subject and activity 
levels.  

Project Data URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data was downloaded and unzipped to an R working directory. The file structure is
shown below. 
 
[File Structure]
UCI HAR Dataset (dir)
activity_labels.txt
features.txt
features_info.txt
README.txt
UCI HAR Dataset/test (dir)
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/test/Inertial Signals (dir)
UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt
UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt
UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt
UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt
UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt
UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt
UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt
UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt
UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt
UCI HAR Dataset/train (dir)
UCI HAR Dataset/train/subject_test.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
UCI HAR Dataset/train/Inertial Signals (dir)
UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt
UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt
UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt
UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt
UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt
UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt
UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt
UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt
UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt

[File Usage]
In order to piece together the primary data set, we need to
attach appropriate labels to the rows and columns. 
(note: I also created an additional column for "type", identifying 
the test or train subject groups.)

Primary data sets:
* UCI HAR Dataset/test/X_test.txt  (2947 observations x 561 measurements)
* UCI HAR Dataset/train/X_train.txt  (7352 observations x 561 measurements)

Features: (columns heading)
* features.txt (561 rows)
features.txt contain column headings for the Primary data sets. Arrange by row,
the features table must be transposed, then used as column headings for the
primary data sets.
(note: this step should be done prior to adding columns to the primary data sets)

Type: (new column)
I added a type column (named type) to each of the primary data set which identifies either 
the "test"" or "train"" group. This wasnt't necessary, but it may provide additional 
flexibility in the future on other types of analysis.

Activity id: (new column)
* UCI HAR Dataset/test/y_test.txt (2947 observations)
* UCI HAR Dataset/train/y_train.txt (7352 observations)
y_test.txt and y_train.txt contain activity vector ids and
are added as the first column in the respective primary
data sets.

Acitivity labels: (new column)
* activity_labels.txt (6 rows x 2 columns)
activity labels are joined on the first column (id) of each
of the primary data sets. This creates an addition column within
each data set that contains a text description of each activity.

Subject column (new column)
* UCI HAR Dataset/test/subject_test.txt (2947 rows)
* UCI HAR Dataset/train/subject_train.txt (7352 rows)
contents of subject_test.txt and subject_train.txt are
added as the first column in the respective primary 
data sets. 

[Data Frames]
* dftest (2947 observations x 565 measurements)
* dftrain  (7352 observations x 565 measurements)
At this point, you've built the dftest and dftrain data.frames
which contain a par of complete labeled data sets for all 
observations

* dftraintest  (10299 observations x 565 measurements) 
Complete data set where dftest and dftrain are merged together
as single data.frame

* dfmeantraintest  (10299 observations x 46 measurements)  
dfmeantraintest is a subset of dftraintest and consists of all
data having column headings that includes "mean" within their title.
(note: subject, id, activity and type are excluded from this 
data.frame)


* dfsdtraintest  (10299 observations x 33 measurements) 
dfmeantraintest is a subset of dftraintest and consists of all
data having column headings that includes "std" within their title.
(note: subject, id, activity and type are excluded from this 
data.frame)

* dfmeansdtraintest  (10299 observations x 83 measurements) 
dfmeansdtraintest is a merged version of dfmeantraintest and dfsdtraintest, 
where subject, id, activity and type are added back into the
data.frame as identifying columns.

* dffinal (40 observations x 81 measurements) 
dffinal is the aggregation of means grouped by subject and activity.
This is the final data set for this assignment.


###########################################################

(note: The raw data found in the Inertial Signals folders was
not used. All test and train data were obtained from the
X-test.txt and X-train.txt files found in the respective
directories which contained summarized values created by
the Inertial Signals content.)


[Orignal data sets]
The data was provided by 
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================
[Raw description]
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 




