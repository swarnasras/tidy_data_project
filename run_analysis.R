setwd("./coursera/course-cleaning data/")
#Read training dataset's features, activity label and subject data
tr.fea=read.table("./UCI HAR Dataset/test/X_test.txt")
tr.lab=read.table("./UCI HAR Dataset/test/y_test.txt")
tr.sub=read.table("./UCI HAR Dataset/test/subject_test.txt")
#Read test dataset's features, activity label and subject data
test.fea=read.table("./UCI HAR Dataset/train/X_train.txt")
test.lab=read.table("./UCI HAR Dataset/train/y_train.txt")
test.sub=read.table("./UCI HAR Dataset/train/subject_train.txt")
#Merges the three training datasets by column- subject column, label column followed by the 561 feature columns)
tr=cbind(tr.sub,tr.lab,tr.fea)
#Merges the three test datasets by column- subject column, label column followed by the 561 feature columns)
test=cbind(test.sub,test.lab,test.fea)

#Adds a new column in the above training and test dataset called "datasource" indicating whether the data was test data or training data
#This is unnecessary step but was used for my reference. It is later ignored during creation of the final tidy data
tr$datasource="train"
test$datasource="test"

#Merges train and test datasets
data=rbind(tr,test)

#Removes other data
rm(tr.fea)
rm(tr.lab)
rm(tr.sub)
rm(test.fea)
rm(test.lab)
rm(test.sub)
rm(tr)
rm(test)

#Read the feature names file for 
feat.names=read.table("./UCI HAR Dataset/features.txt")

#Read the activity label file
act.lab=read.table("./UCI HAR Dataset/activity_labels.txt")

#Properly naming the column names
names(data)=c("sub","lab",as.character(feat.names[,2]),"datasource")

#Extracts only the measurements on mean() and std() i.e. the mean and standard deviation for each measurement 
#This includes the meanfreq() i.e. the weighted average of the frequency components to obtain a mean frequency

ind1= grep("mean()",names(data))
ind2= grep("std()",names(data))
indices=c(1,2,564,ind1,ind2)
data=data[indices]
#Getting the activity labels for the data from the "act.lab" dataframe
data=merge(data,act.lab,by.x="lab",by.y="V1",all=T)
#Cleaning up columns and ordering the data
data[1]=data[83]
data=data[,c(2,1,3:82)]
order(data,data$sub,data$lab)

#Summarizing the mean data of 79 features by person and activity labels 
dmelt=melt(data,id=(c("sub","lab","datasource")))
tidydata=dcast(dmelt,sub+lab~variable,mean)
write.table(tidydata,"tidy_data.txt")
