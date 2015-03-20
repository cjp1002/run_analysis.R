##open the plyr package
library(plyr)

##create a data folder in the working directory if it does not already exist 
##then download file and unzip it to the data folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "./data/Dataset.zip", quiet=TRUE)
    unzip(zipfile="./data/Dataset.zip",exdir="./data")

##set filepath of unzipped files, list the files
##present their structure to the console
unzipfilepath <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(unzipfilepath, recursive=TRUE)
files
    ActivityTrain <- read.table(file.path(unzipfilepath, "train", "Y_train.txt"), header = FALSE)
    ActivityTest  <- read.table(file.path(unzipfilepath, "test" , "Y_test.txt" ), header = FALSE)
    SubjectTrain <- read.table(file.path(unzipfilepath, "train", "subject_train.txt"), header = FALSE)
    SubjectTest  <- read.table(file.path(unzipfilepath, "test" , "subject_test.txt"), header = FALSE)
    FeaturesTrain <- read.table(file.path(unzipfilepath, "train", "X_train.txt"), header = FALSE)
    FeaturesTest  <- read.table(file.path(unzipfilepath, "test" , "X_test.txt" ), header = FALSE)
    str(ActivityTrain)
    str(ActivityTest)
    str(SubjectTrain)
    str(SubjectTest)
    str(FeaturesTrain)
    str(FeaturesTest)

##combine the Train and Test data, clean it a little
##present their structure of the Data to the console
Subjectdata <- rbind(SubjectTrain, SubjectTest)
Activitydata <- rbind(ActivityTrain, ActivityTest)
Featuresdata <- rbind(FeaturesTrain, FeaturesTest)
names(Subjectdata) <- c("subject")
names(Activitydata) <- c("activity")
FeaturesdataNames <- read.table(file.path(unzipfilepath, "features.txt"),head=FALSE)
names(Featuresdata) <- FeaturesdataNames$V2
Data <- cbind(Featuresdata, Subjectdata, Activitydata)
subFeaturesdataNames <- FeaturesdataNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesdataNames$V2)]
selectedNames <- c(as.character(subFeaturesdataNames), "subject", "activity" )
Data <- subset(Data, select=selectedNames)
str(Data)
activityLabels <- read.table(file.path(unzipfilepath, "activity_labels.txt"), header = FALSE)

##name the different activities in easily readable format, send names to the console
head(Data$activity,30)
    names(Data)<-gsub("^t", "time", names(Data))
    names(Data)<-gsub("^f", "frequency", names(Data))
    names(Data)<-gsub("Acc", "Accelerometer", names(Data))
    names(Data)<-gsub("BodyBody", "Body", names(Data))
    names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
    names(Data)<-gsub("Mag", "Magnitude", names(Data))
    names(Data)

##make the final tidydata text file
finalData <- aggregate(. ~subject + activity, Data, mean)
finalData <- finalData[order(finalData$subject, finalData$activity),]
write.table(finalData, file = "tidydata.txt", row.names=FALSE)
