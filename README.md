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
from aggregated measurements of acceleration and angular velocity. 
The data was captured using a Samsung Galaxy S II smartphone. The
final data set is grouped by subject and activity levels.  

[Final Output Units]
The final output contains the average means and average standard
deviations already computed by the Smartlab company. Column
headings containing "acc" represent acceleration expressed in
standard gravity units 'g'. Column headings containing
"gyro" represent angular velocity and are expressed in
radians/second. Each metric contains observations for the
X, Y & Z axis.

[Project Instructions]
1. Merge training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5 From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

(note: The raw data found in the Inertial Signals folders was
not used. All test and train data were obtained from the
X-test.txt and X-train.txt files found in the respective
directories)


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




