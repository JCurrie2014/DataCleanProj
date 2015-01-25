##################################################
#### Getting and Cleaning Data Project ###########
## Written by Jerry Currie 1/24/2015
##################################################
## The goal of this project is to create a tidy dataset from raw, 
## and aggregated accelerometer data collected by the
## Smartlab company. This tidy data set will consist of
## of accelerometer readings from 30 subjects
## performing 6 different physical activities. The final
## data set contains the average mean and average standard deviation
## from aggregated measurements of acceleration and angular velocity. 
## The data was captured using a Samsung Galaxy S II smartphone. The
## final data set is grouped by subject and activity levels.  

############### Load R packages #######################
library(gdata) #use gdata package to filter column names
library(dplyr) #dplyr was also used for sorting data using R
############# End Load R packages #####################


############### Create labels for row & column headings ########
## [feature labels] 
## the feature labels are used as column heading in the test
## and training data sets (aggregated accelerometer data sets)
rfeature<-read.table("./UCI HAR Dataset/features.txt", sep=" ") 
## remove first column from data.frame
rfeature[,1]<-NULL
## transpose rfeature from rows to columns for headings
cfeature<-t(rfeature) #r prefix for rows

#[activity labels]
## read activity labels and give descriptive headings
cactivity<-read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ")   
colnames(cactivity)[1]<-"id"
colnames(cactivity)[2]<-"activity"

## [subject labels]
## read subject labels and give descriptive heading
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt") 
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt") 
colnames(subtrain)[1]<-"subject"
colnames(subtest)[1]<-"subject"

##[test & train labels]
## these labels contain a vector of subject ids used for matching subjects
## with each row of observation
labtrain<-read.table("./UCI HAR Dataset/train/y_train.txt", sep=" ") 
labtest<-read.table("./UCI HAR Dataset/test/y_test.txt", sep=" ") 
#rename 1st column labels to id
colnames(labtrain)[1]<-"id"
colnames(labtest)[1]<-"id"
###################### End Labels ##############################


########## Build merged test/train data frame ##################
## Read train and test data sets
settrain<-read.table("./UCI HAR Dataset/train/X_train.txt") 
settest<-read.table("./UCI HAR Dataset/test/X_test.txt") 

# rename columns using values contained in cfeature 
colnames(settrain)<-cfeature
colnames(settest)<-cfeature  

# Add type column to data frame before merging. This step isn't
# required, but it could be useful in future, if the analyst 
# wants to filter on subject type
labtest$type<-"test"
labtrain$type<-"train"

#merge train/test labels with activity labels (to use descriptive activity labels)
labdestrain<-merge(cactivity,labtrain)
labdestest<-merge(cactivity,labtest)

#merge descriptive activity labels with subject id
labsubtrain<-cbind(subtrain, labdestrain)
labsubtest<-cbind(subtest, labdestest)

#Place all labels at beginning of train/test data sets
dftrain<-cbind(labsubtrain, settrain)
dftest<-cbind(labsubtest, settest)

## merge both test and train data frames into 1
dftraintest<-rbind(dftrain, dftest)
################## End build merged data frame ################



############## Filter data set on mean and std columns ########
# Create a LIST of column headings filtered by mean or std
dfmeansd<-matchcols(dftraintest, with=c("mean", "std"),method="or")

# Create data set having only mean or standard deviation from
# main data set (doesn't include subject, id, activity or type columns)
dfmeantraintest<-dftraintest[,dfmeansd[[1]]]
dfsdtraintest<-dftraintest[,dfmeansd[[2]]] 

# combine subject, id, activity and type columns to mean and std subsets
# to create the final data set
dfmeansdtraintest<-cbind(dftraintest[,1:4],dfmeantraintest,dfsdtraintest)
# Sort the tidy data set containing mean and standard deviation values 
dfmeansdtraintest<-arrange(dfmeansdtraintest, subject, id)
############## End Filter on mean and std   ################


################# Aggregate final results #####################
## Aggregate the means grouped by subject and activity
aggfinal<-aggregate(dfmeansdtraintest[, c(5:83)], list(dfmeansdtraintest$subject,dfmeansdtraintest$activity), mean)
# Add column headers that were lost during aggregation
colnames(aggfinal)[1]<-"subject"
colnames(aggfinal)[2]<-"activity" 
dffinal<-arrange(aggfinal, subject, activity)
################# End Aggregate final results ################## 

########### Write Final results to disk  ###################
write.table(dffinal, "dffinal.txt", row.name=FALSE) 
################# End write to disk  ########################            
            

 
 