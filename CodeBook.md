##Original data files used
- X_test.txt
- y_test.txt
- subject_test.txt
- X_train.txt
- y_train.txt
- subject_train.txt
- activity_labels.txt
- features.txt

##Data transformations to clean up the original data files and convert it to tidy data
Set the workind directory

```
setwd("./Downloads/swarna/course-cleaning data/")
```

Read training dataset's features, activity label and subject data

```
tr.fea=read.table("./UCI HAR Dataset/test/X_test.txt")
tr.lab=read.table("./UCI HAR Dataset/test/y_test.txt")
tr.sub=read.table("./UCI HAR Dataset/test/subject_test.txt")
```

Read test dataset's features, activity label and subject data

```
test.fea=read.table("./UCI HAR Dataset/train/X_train.txt")
test.lab=read.table("./UCI HAR Dataset/train/y_train.txt")
test.sub=read.table("./UCI HAR Dataset/train/subject_train.txt")
```

Merges the three training datasets by column- subject column, label column followed by the 561 feature columns)

```
tr=cbind(tr.sub,tr.lab,tr.fea)
```

Merges the three test datasets by column- subject column, label column followed by the 561 feature columns)

```
test=cbind(test.sub,test.lab,test.fea)
```


Adds a new column in the above training and test dataset called "datasource" indicating whether the data was test data or training data

This is unnecessary step but was used for my reference. It is later ignored during creation of the final tidy data

```
tr$datasource="train"
test$datasource="test"
```

Merges train and test datasets

```
data=rbind(tr,test)
```

Removes unnecessary data variables

```
rm(tr.fea)
rm(tr.lab)
rm(tr.sub)
rm(test.fea)
rm(test.lab)
rm(test.sub)
rm(tr)
rm(test)
```

Read the feature names file

```
feat.names=read.table("./UCI HAR Dataset/features.txt")
```

Read the activity label file

```
act.lab=read.table("./UCI HAR Dataset/activity_labels.txt")
```

Properly naming the column names of the dataset

```
names(data)=c("sub","lab",as.character(feat.names[,2]),"datasource")
```

Extracts only the measurements on mean() and std() i.e. the mean and standard deviation for each measurement 

This includes the meanfreq() i.e. the weighted average of the frequency components to obtain a mean frequency

```
ind1= grep("mean()",names(data))
ind2= grep("std()",names(data))
indices=c(1,2,564,ind1,ind2)
data=data[indices]
```

Getting the activity labels for the data from the "act.lab" dataframe

```
data=merge(data,act.lab,by.x="lab",by.y="V1",all=T)
```

Cleaning up columns and ordering the data

```
data[1]=data[83]
data=data[,c(2,1,3:82)]
order(data,data$sub,data$lab)
```

Summarizing the mean data of 79 features by person and activity labels 

```
dmelt=melt(data,id=(c("sub","lab","datasource")))
tidydata=dcast(dmelt,sub+lab~variable,mean)
write.table(tidydata,"tidy_data1.txt")
```

##Variables in the tidy data
The 81 variable names of the transformed tidy are described below
They contain the 79 selected observations of mean and standard deviation features for each person and activity
S.No.: Variable.name: Description

1. sub: Subject
2. lab: Activity label
3. tBodyAcc-mean()-X: Mean value of  time domain signal for body acceleration
4. tBodyAcc-mean()-Y: Mean value of  time domain signal for body acceleration
5. tBodyAcc-mean()-Z: Mean value of  time domain signal for body acceleration
6. tGravityAcc-mean()-X: Mean value of  time domain signal for gravity acceleration
7. tGravityAcc-mean()-Y: Mean value of  time domain signal for gravity acceleration
8. tGravityAcc-mean()-Z: Mean value of  time domain signal for gravity acceleration
9. tBodyAccJerk-mean()-X: Mean value of  time domain jerk signal for body linear acceleration
10. tBodyAccJerk-mean()-Y: Mean value of  time domain jerk signal for body linear acceleration
11. tBodyAccJerk-mean()-Z: Mean value of  time domain jerk signal for body linear acceleration
12. tBodyGyro-mean()-X: Mean value of  time domain signal for body angular velocity
13. tBodyGyro-mean()-Y: Mean value of  time domain signal for body angular velocity
14. tBodyGyro-mean()-Z: Mean value of  time domain signal for body angular velocity
15. tBodyGyroJerk-mean()-X: Mean value of  time domain jerk signal for body angular velocity
16. tBodyGyroJerk-mean()-Y: Mean value of  time domain jerk signal for body angular velocity
17. tBodyGyroJerk-mean()-Z: Mean value of  time domain jerk signal for body angular velocity
18. tBodyAccMag-mean(): Mean value of  magnitude of time domain signal for body linear acceleration
19. tGravityAccMag-mean(): Mean value of  magnitude of time domain signal for gravity acceleration
20. tBodyAccJerkMag-mean(): Mean value of  magnitude of time domain jerk signal for body linear acceleration
21. tBodyGyroMag-mean(): Mean value of  magnitude of time domain signal for body agular velocity
22. tBodyGyroJerkMag-mean(): Mean value of  magnitude of time domain jerk signal for body angular velocity
23. fBodyAcc-mean()-X: Mean value of  frequency domain signal for body acceleration
24. fBodyAcc-mean()-Y: Mean value of  frequency domain signal for body acceleration
25. fBodyAcc-mean()-Z: Mean value of  frequency domain signal for body acceleration
26. fBodyAcc-meanFreq()-X: Weighted average of the frequency components to obtain a mean frequency frequency domain signal for body acceleration
27. fBodyAcc-meanFreq()-Y: Weighted average of the frequency components to obtain a mean frequency frequency domain signal for body acceleration
28. fBodyAcc-meanFreq()-Z: Weighted average of the frequency components to obtain a mean frequency frequency domain signal for body acceleration
29. fBodyAccJerk-mean()-X: Mean value of  frequency domain jerk signal for body linear acceleration
30. fBodyAccJerk-mean()-Y: Mean value of  frequency domain jerk signal for body linear acceleration
31. fBodyAccJerk-mean()-Z: Mean value of  frequency domain jerk signal for body linear acceleration
32. fBodyAccJerk-meanFreq()-X: Weighted average of the frequency components to obtain a mean frequency frequency domain jerk signal for body linear acceleration
33. fBodyAccJerk-meanFreq()-Y: Weighted average of the frequency components to obtain a mean frequency frequency domain jerk signal for body linear acceleration
34. fBodyAccJerk-meanFreq()-Z: Weighted average of the frequency components to obtain a mean frequency frequency domain jerk signal for body linear acceleration
35. fBodyGyro-mean()-X: Mean value of  frequency domain signal for body angular velocity
36. fBodyGyro-mean()-Y: Mean value of  frequency domain signal for body angular velocity
37. fBodyGyro-mean()-Z: Mean value of  frequency domain signal for body angular velocity
38. fBodyGyro-meanFreq()-X: Weighted average of the frequency components to obtain a mean frequency frequency domain signal for body angular velocity
39. fBodyGyro-meanFreq()-Y: Weighted average of the frequency components to obtain a mean frequency frequency domain signal for body angular velocity
40. fBodyGyro-meanFreq()-Z: Weighted average of the frequency components to obtain a mean frequency frequency domain signal for body angular velocity
41. fBodyAccMag-mean(): Mean value of  magnitude of frequency domain signal for body linear acceleration
42. fBodyAccMag-meanFreq(): Weighted average of the frequency components to obtain a mean frequency magnitude of frequency domain signal for body linear acceleration
43. fBodyBodyAccJerkMag-mean(): Mean value of  magnitude of frequency domain jerk signal for body linear acceleration
44. fBodyBodyAccJerkMag-meanFreq(): Weighted average of the frequency components to obtain a mean frequency magnitude of frequency domain jerk signal for body linear acceleration
45. fBodyBodyGyroMag-mean(): Mean value of  magnitude of frequency domain signal for body angular velocity
46. fBodyBodyGyroMag-meanFreq(): Weighted average of the frequency components to obtain a mean frequency magnitude of frequency domain signal for body angular velocity
47. fBodyBodyGyroJerkMag-mean(): Mean value of  magnitude of frequency domain jerk signal for body angular velocity
48. fBodyBodyGyroJerkMag-meanFreq(): Weighted average of the frequency components to obtain a mean frequency magnitude of frequency domain jerk signal for body angular velocity
49. tBodyAcc-std()-X: Standard deviation of  time domain signal for body acceleration
50. tBodyAcc-std()-Y: Standard deviation of  time domain signal for body acceleration
51. tBodyAcc-std()-Z: Standard deviation of  time domain signal for body acceleration
52. tGravityAcc-std()-X: Standard deviation of  time domain signal for gravity acceleration
53. tGravityAcc-std()-Y: Standard deviation of  time domain signal for gravity acceleration
54. tGravityAcc-std()-Z: Standard deviation of  time domain signal for gravity acceleration
55. tBodyAccJerk-std()-X: Standard deviation of  time domain jerk signal for body linear acceleration
56. tBodyAccJerk-std()-Y: Standard deviation of  time domain jerk signal for body linear acceleration
57. tBodyAccJerk-std()-Z: Standard deviation of  time domain jerk signal for body linear acceleration
58. tBodyGyro-std()-X: Standard deviation of  time domain signal for body angular velocity
59. tBodyGyro-std()-Y: Standard deviation of  time domain signal for body angular velocity
60. tBodyGyro-std()-Z: Standard deviation of  time domain signal for body angular velocity
61. tBodyGyroJerk-std()-X: Standard deviation of  time domain jerk signal for body angular velocity
62. tBodyGyroJerk-std()-Y: Standard deviation of  time domain jerk signal for body angular velocity
63. tBodyGyroJerk-std()-Z: Standard deviation of  time domain jerk signal for body angular velocity
64. tBodyAccMag-std(): Standard deviation of  magnitude of time domain signal for body linear acceleration
65. tGravityAccMag-std(): Standard deviation of  magnitude of time domain signal for gravity acceleration
66. tBodyAccJerkMag-std(): Standard deviation of  magnitude of time domain jerk signal for body linear acceleration
67. tBodyGyroMag-std(): Standard deviation of  magnitude of time domain signal for body agular velocity
68. tBodyGyroJerkMag-std(): Standard deviation of  magnitude of time domain jerk signal for body angular velocity
69. fBodyAcc-std()-X: Standard deviation of  frequency domain signal for body acceleration
70. fBodyAcc-std()-Y: Standard deviation of  frequency domain signal for body acceleration
71. fBodyAcc-std()-Z: Standard deviation of  frequency domain signal for body acceleration
72. fBodyAccJerk-std()-X: Standard deviation of  frequency domain jerk signal for body linear acceleration
73. fBodyAccJerk-std()-Y: Standard deviation of  frequency domain jerk signal for body linear acceleration
74. fBodyAccJerk-std()-Z: Standard deviation of  frequency domain jerk signal for body linear acceleration
75. fBodyGyro-std()-X: Standard deviation of  frequency domain signal for body angular velocity
76. fBodyGyro-std()-Y: Standard deviation of  frequency domain signal for body angular velocity
77. fBodyGyro-std()-Z: Standard deviation of  frequency domain signal for body angular velocity
78. fBodyAccMag-std(): Standard deviation of  magnitude of frequency domain signal for body linear acceleration
79. fBodyBodyAccJerkMag-std(): Standard deviation of  magnitude of frequency domain jerk signal for body linear acceleration
80. fBodyBodyGyroMag-std(): Standard deviation of  magnitude of frequency domain signal for body angular velocity
81. fBodyBodyGyroJerkMag-std(): Standard deviation of  magnitude of frequency domain jerk signal for body angular velocity
