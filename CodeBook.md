##################################################
#### Getting and Cleaning Data Project ###########
################# Code Book ######################
Written by Jerry Currie 1/24/2015
##################################################
## Contents
* Version Information
* Pseudo Code
* Output Units
* Files & Directories
* Data construction
* Variable descriptions (final output)
##################################################
##################################################


## Version Information
Computer OS: Windows 7 
R Version: 3.1.2 
R Studio Version: 0.98.1091 
dplyr package:0.3.0.2
gdata package:2.13.3

## Pseudo Code
1. Load R packages
2. Create labels
3. Build merged data set
4. Filter data set by means and standard deviations
5. Aggregate final results (grouped by subject, activity)
6. Write Final results to disk

##  Output Units
The final output contains the average means and average standard
deviations already computed by the Smartlab company. Column
headings containing "acc" represent acceleration expressed in
standard gravity units 'g'. Column headings containing
"gyro" represent angular velocity and are expressed in
radians/second. Each metric contains observations for the
X, Y & Z axis.

##  Files & Directories
1. Create a new R project and place the file
run_analysis.R inside the working folder.
(run_analysis.R can be obtained from https://github.com/JCurrie2014/DataCleanProj)

2. Download the data set from the URL below. 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

3. Unzip the contents of getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into the
R project working directory. Use should now have a folder named "UCI HAR Dataset"
within your R project directory.

4. Inside "UCI HAR Dataset" you will find a Readme.txt file that provides the 
details of the files and directory structure. It also contains descriptions of
what each file does.

##  Data construction & variable definitions
1, feature list by rows (will be used in column headings)
rfeature<-read.table("./UCI HAR Dataset/features.txt", sep=" ") 
        1a. remove first column from data.frame
        rfeature[,1]<-NULL

2. transpose into column for headings
cfeature<-t(rfeature) #r prefix for rows

3.read activity labels and give descriptive headings
cactivity<-read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")   

4. Assign column names
colnames(cactivity)[1]<-"id"
colnames(cactivity)[2]<-"activity"

5.read subject labels and give descriptive heading
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt") 
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt") 

6. Assign column names
colnames(subtrain)[1]<-"subject"
colnames(subtest)[1]<-"subject"

7. Get train and test labels for marking each row in data sets 
labtrain<-read.table("./UCI HAR Dataset/train/y_train.txt", sep=" ") 
labtest<-read.table("./UCI HAR Dataset/test/y_test.txt", sep=" ") 

8, Assign column lables
colnames(labtrain)[1]<-"id"
colnames(labtest)[1]<-"id"

9. Read train and test data sets into data frames
settrain<-read.table("./UCI HAR Dataset/train/X_train.txt") 
settest<-read.table("./UCI HAR Dataset/test/X_test.txt") 

10. rename columns using values contained in cfeature 
colnames(settrain)<-cfeature
colnames(settest)<-cfeature  

11. add column named "type" to labtest & labtrain data frames
labtest$type<-"test"
labtrain$type<-"train"

12.merge train/test labels with activity labels (to use descriptive activity labels)
labdestrain<-merge(cactivity,labtrain)
labdestest<-merge(cactivity,labtest)

13. merge descriptive activity labels with subject id
labsubtrain<-cbind(subtrain, labdestrain)
labsubtest<-cbind(subtest, labdestest)

14. Place all labels at beginning of train/test data sets
dftrain<-cbind(labsubtrain, settrain)
dftest<-cbind(labsubtest, settest)

15. merge both test and train data frames into 1
dftraintest<-rbind(dftrain, dftest) 

16. Create a LIST of column headings filtered by mean or std
dfmeansd<-matchcols(dftraintest, with=c("mean", "std"),method="or")

17.  Create data set having only mean or standard deviation from
main data set (excluding subject, id, activity or type columns)
dfmeantraintest<-dftraintest[,dfmeansd[[1]]]
dfsdtraintest<-dftraintest[,dfmeansd[[2]]] 

18. combine subject, id, activity and type columns to mean and std subsets
to create the final data set
dfmeansdtraintest<-cbind(dftraintest[,1:4],dfmeantraintest,dfsdtraintest)

19. Sort the tidy data set containing mean and standard deviation values 
dfmeansdtraintest<-arrange(dfmeansdtraintest, subject, id)
 
20. Aggregate the means grouped by subject and activity
aggfinal<-aggregate(dfmeansdtraintest[, c(5:83)], list(dfmeansdtraintest$subject,dfmeansdtraintest$activity), mean)

21. Add column headers that were lost during aggregation
colnames(aggfinal)[1]<-"subject"
colnames(aggfinal)[2]<-"activity" 

22. Sort final results
dffinal<-arrange(aggfinal, subject, activity)

23.Write final results to disk
write.table(dffinal, "dffinal.txt", row.name=FALSE) 


## Variable descriptions (final output)
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


subject - Individual id of person being monitored
activity - acitivity being monitored (Walking, Laying, Sitting etc...)
tBodyAcc-mean()-X - mean(time Body Acceleration) measured in g's (X,Y,Z axis)
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tGravityAcc-mean()-X- mean(time Gravity Acceleration) measured in g's (X,Y,Z axis)
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tBodyAccJerk-mean()-X- mean(time Body Jerk aAcceleration) measured in g's (X,Y,Z axis)
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyGyro-mean()-X - mean(time Body Gyro) measured in radians/second (X,Y,Z axis)
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyroJerk-mean()-X - mean(time Body Gyro jerk) measured in radians/second (X,Y,Z axis)
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyAccMag-mean() - mean(time Body Acceleration Magnitude) measured in g's 
tGravityAccMag-mean() - mean(time Gavity Acceleration Magnitude) measured in g's 
tBodyAccJerkMag-mean() - mean(time Body Acceleration Jerk Magnitude) measured in g's 
tBodyGyroMag-mean() - mean(time Body Gyro Magnitude) measured in radians/second
tBodyGyroJerkMag-mean() - mean(time Body Acceleration magnitude) measured in radians/second
fBodyAcc-mean()-X - mean(time Body acceleration) measured in g's (X,Y,Z axis)
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-meanFreq()-X - mean(mean(frequency) Body Acceleration) measured in g's (X,Y,Z axis)
fBodyAcc-meanFreq()-Y
fBodyAcc-meanFreq()-Z
fBodyAccJerk-mean()-X - mean(frequency Body Acceleration Jerk) measured in g's (X,Y,Z axis)
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-meanFreq()-X - mean(mean(frequency) Body Acceleration Jerk) measured in g's (X,Y,Z axis)
fBodyAccJerk-meanFreq()-Y
fBodyAccJerk-meanFreq()-Z
fBodyGyro-mean()-X  - mean(frequency Body Gyro) measured in radians/second (X,Y,Z axis)
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-meanFreq()-X  - mean(mean(frequency) Body Gyro) measured in radians/second (X,Y,Z axis)
fBodyGyro-meanFreq()-Y
fBodyGyro-meanFreq()-Z
fBodyAccMag-mean()  - mean(frequency Body Acceleration Magnitude) measured in g's 
fBodyAccMag-meanFreq() - mean(mean(frequency) Body Acceleration Magnitude) measured in g's 
fBodyBodyAccJerkMag-mean()  - mean(frequency Body Acceleration Jerk Magnitude) measured in g's 
fBodyBodyAccJerkMag-meanFreq()  - mean(mean(frequency) Body Acceleration Jerk Magnitude) measured in g's 
fBodyBodyGyroMag-mean()  - mean(frequency Body Gyro Magnitude) measured in radians/second
fBodyBodyGyroMag-meanFreq()  - mean(mean(frequency) Body Gyro Magnitude) measured in radians/second
fBodyBodyGyroJerkMag-mean()  - mean(frequency Body Gyro Jerk Magnitude) measured in radians/second
fBodyBodyGyroJerkMag-meanFreq()  - mean(mean(frequency) Body Gyro Jerk Magnitude) measured in radians/second
tBodyAcc-std()-X - std(time Body Acceleration) measured in g's (X,Y,Z axis)
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-std()-X - std(time Gravity Acceleration) measured in g's (X,Y,Z axis)
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-std()-X - std(time Body Acceleration Jerk ) measured in g's (X,Y,Z axis)
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-std()-X - std(time Body Gyro) measured in radians/second (X,Y,Z axis)
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-std()-X - std(time Body Gyro Jerk) measured in radians/second (X,Y,Z axis)
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-std() - std(time Body Acceleration Magnitude) measured in g's 
tGravityAccMag-std()  - std(time Gravity Acceleration Magnitude) measured in g's 
tBodyAccJerkMag-std()  - std(time Body Acceleration Jerk Magnitude) measured in g's 
tBodyGyroMag-std()  - std(time Body Gyro Magnitude) measured in radians/second
tBodyGyroJerkMag-std()  - std(time Body Gyro Jerk Magnitude) measured in radians/second
fBodyAcc-std()-X - std(frequency Body Acceleration) measured in g's (X,Y,Z axis)
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-std()-X - std(frequency Body Acceleration Jerk) measured in g's (X,Y,Z axis)
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-std()-X  - std(frequency Body Gyro) measured in radians/second (X,Y,Z axis)
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-std()  - std(frequency Body Acceleration Magnitude) measured in g's 
fBodyBodyAccJerkMag-std() - std(frequency Body Acceleration Jerk Magnitude) measured in g's  
fBodyBodyGyroMag-std()  - std(frequency Body Gyro Magnitude) measured in radians/second
fBodyBodyGyroJerkMag-std()  - std(frequency Body Gyro Jerk Magnitude) measured in radians/second

 