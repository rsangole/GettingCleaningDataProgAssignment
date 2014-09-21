#Set working directory
setwd("~/Documents/Data Science/Coursera/3 Cleaning Data/Prog Assignment/UCI HAR Dataset")

#Include relevant libraries
library(dplyr)
library(reshape2)

#Import data common to test & train datasets:
#features.txt: names of data columns
features <- read.table("features.txt",sep="")
features <- tbl_df(features)
names <- as.list(select(features,2))
#activity_labels.txt: names of the activities
activities <- read.table("activity_labels.txt")
activities <- tbl_df(activities)
act <- as.list(select(activities,2))

#Import test dataset with raw readings
data <- read.table("test/X_test.txt",header = F,sep = "")
test <- tbl_df(data)
#Rename generic column names to the correct column names in features.txt
test <- setNames(test,as.character(names$V2))
#Import subject number listing for test dataset 
testsubject <- read.table("test/subject_test.txt")
#Import activity number listing for test dataset
testactivity <- read.table("test/y_test.txt")

#Combine these three datasets together
test <- cbind(dataset="test",testsubject,testactivity,test)
colnames(test)[c(2,3)] <- c("subject","activity") #Column rename for readability

#Import train dataset with raw readings
data <- read.table("train/X_train.txt",header = F,sep="")
train <- tbl_df(data)
#Rename generic column names to the correct column names in features.txt
train <- setNames(train,as.character(names$V2))
#Import subject number listing for train dataset 
trainsubject <- read.table("train/subject_train.txt")
#Import activity number listing for train dataset
trainactivity <- read.table("train/y_train.txt")
#Combine these three datasets together
train <- cbind(dataset="train",trainsubject,trainactivity,train)
colnames(train)[c(2,3)] <- c("subject","activity") #Column rename for readability

#Step 1 -> Combine test and train datasets into one, called 'combined'
combined <- rbind(test,train)

#Step 2 -> Select only columns that contain mean() or std() programatically
reduced <- select(combined,dataset,subject,activity,contains("mean\\(\\)|std\\(\\)"))

#Step 3 -> This code uses the labels under activity_labels.txt and assigns them to
#the activity numbers in the combined dataset as factors
label <- gl(n=dim(activities)[1],k=1,labels=activities$V2)
reduced$activity <- factor(reduced$activity,labels=label)

#Make tidy long form of data
tidy <- melt(reduced,id.vars=c("dataset","subject","activity"),
               value.name ="value",variable.name="measurement_type",
               factorsAsStrings=TRUE)
#Convert factor variables into character variables, for easier processing downstream
tidy$dataset <- as.character(tidy$dataset)
tidy$activity <- as.character(tidy$activity)
tidy$measurement_type <- as.character(tidy$measurement_type)

#Step 4 -> Rename measurement_type programatically to make it easier for user to read
tidy$measurement_type <- sub(pattern = "^t",replacement = "Time-",x =tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "^f",replacement = "Freq-",x =tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "\\(\\)",replacement = "",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "std",replacement = "Std_Dev",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "BodyAcc",replacement = "Accel",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "GravityAcc",replacement = "Gravity",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "BodyAccJerk",replacement = "Jerk",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "BodyGyro",replacement = "Gyroscope",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "BodyGyroJerk",replacement = "GyroJerk",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "BodyAccMag",replacement = "Accel_Magnitude",x=tidy$measurement_type)
tidy$measurement_type <- sub(pattern = "GravityAccMag",replacement = "Gravity_Magnitude",x=tidy$measurement_type)

#Step 5 - Summarise means for each subject, for each activity
result <- dcast(tidy,subject+activity~measurement_type,mean)

#Write final result tidy dataset to a file for evaluation
write.table(result,"result.txt",row.names = F)