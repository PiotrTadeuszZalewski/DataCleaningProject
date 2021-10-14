library(tidyverse)
setwd("./UCI HAR Dataset")
#
# read features and activity names
#
features<-read.table("features.txt")
activity<-read.table("activity_labels.txt")
#
# read training: subject, activity and measurements
#
subject_train<-read.table("./train/subject_train.txt")
activity_train<-read.table("./train/y_train.txt")
activity_train<-merge(activity_train,activity)
x_train<-read.table("./train/X_train.txt")
#
# make tidy training data set
#
names(x_train)<-features$V2
x_train<-cbind(subject=subject_train$V1,activity=activity_train$V2,x_train)
#
# read testing: subject, activity and measurements
#
subject_test<-read.table("./test/subject_test.txt")
activity_test<-read.table("./test/y_test.txt")
activity_test<-merge(activity_test,activity)
x_test<-read.table("./test/X_test.txt")
#
# make tidy test data set
#
names(x_test)<-features$V2
x_test<-cbind(subject=subject_test$V1,activity=activity_test$V2,x_test)
#
# Merge train and test data
#
data<-rbind(x_train,x_test)
#
# Select subject, activity and measurement mean and std columns
#
data<-select(data,grep("subject|activity|.*mean.*|.*std.*",names(data)))
#
# Averages by subject and activity
#
data<-group_by(data,subject,activity)
average<-summarise_all(data,mean)
#
# Write Data Files
#
write.csv(data,file="./data.csv",row.names=FALSE)
write.csv(average,file="./average.csv",row.names=FALSE)
