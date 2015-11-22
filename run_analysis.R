
# reading the file, unzip, and data clean
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile<-"Project_2.zip"
method<-"libcurl"
download.file(url, destfile, method)
unzip (destfile)

#Input Data
Y_test  <- read.table("./UCI HAR Dataset/test/Y_test.txt" ,header =FALSE)
Y_train  <- read.table("./UCI HAR Dataset/train/Y_train.txt" ,header =FALSE)
X_test  <- read.table("./UCI HAR Dataset/test/X_test.txt" ,header = FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
subject_train  <- read.table("./UCI HAR Dataset/train/subject_train.txt" ,header =FALSE)
subject_test  <- read.table("./UCI HAR Dataset/test/subject_test.txt" ,header =FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)

#Merge the training and the test sets 
All_Data<- rbind(X_train, X_test)

#Extract only the measurements on the mean and std
mean_std_features<-features$V2[grep("mean|std",features$V2)]
mean_std_Data = All_Data[,mean_std_features]

#Use descriptive activity names to name the activities 
#Appropriately labels the data set with descriptive Var. names
names(mean_std_Data)<-mean_std_features
All_Activity<-rbind(Y_train, Y_test)
All_Activity[1] = activity_labels[All_Activity[,1],2]
names(All_Activity)<-c("Activity")
All_Subjects<-rbind(subject_train, subject_test)
names(All_Subjects)<-c("Subject")
All_Data<-cbind(mean_std_Data,All_Activity) 
All_Data<-cbind(All_Data,All_Subjects)

#create a second, independent tidy data set with the average of #each variable for each activity and each subject.
melt_All_Data = melt(All_Data, id = c("Activity","Subject"),measure.vars = as.character(mean_std_features))
Tidy_Data   = dcast(melt_All_Data, Activity+Subject ~ variable, mean)
write.table(Tidy_Data, file = "./Tidy_Data.txt",row.name=FALSE)










