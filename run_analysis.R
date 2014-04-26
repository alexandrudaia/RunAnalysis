# The data  source of  this  project   can  be  found  at
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# The project  contains  one script called  run_analysis.R who 
# resolves  all the  requirments of  the  projct

run_analysis=function()
{
  
# From the  main  folder   read  the  activity labels  and  features 
setwd("C:/Users/anonymus/Desktop/UCI HAR Dataset")
activity_labels=data.frame(read.table("activity_labels.txt"));
features=data.frame(read.table("features.txt"));

# From the  train folder  we read  the  training set , training labels 
# ,subjects  trained and  we  set   the correlation between data

setwd("C:/Users/anonymus/Desktop/UCI HAR Dataset/train");
X_train=data.frame(read.table("X_train.txt"))
y_train=data.frame(read.table("y_train.txt"))
colnames(y_train)=("Activity_code")
subject_train=data.frame(read.table("subject_train.txt"))
colnames(subject_train)="Subject"
labels_train=y_train
labels_train[,1]=activity_labels[y_train[,1],2]
colnames(labels_train)="Activity_labels"

# From the  test folder  we read  the  test set , test labels 
# ,subjects  test and  we  set   the correlation between data

setwd("C:/Users/anonymus/Desktop/UCI HAR Dataset/test");
X_test=data.frame(read.table("X_test.txt"));
y_test=data.frame(read.table("y_test.txt"));
colnames(y_test)="Activity_code"
subject_test=data.frame(read.table("subject_test.txt"));
colnames(subject_test)="Subject"
labels_test=y_test
labels_test[,1]=activity_labels[y_test[,1],2]
colnames(labels_test)="Activity_labels"

# We  extract from all the  measurment  variables  only  the  ones  that
# corresponds    to mean  or  std  measurement , using  regular  expressions
# more exactly  the grep  function and  then  we subset  the  data  we need.

mean_index=grep("(.*)mean(.*)",features[,2])
std_index=grep("(.*)std(.*)",features[,2])
only_mean_and_std_index=c(mean_index,std_index)
xtrain_only=subset(X_train,select= only_mean_and_std_index)
xtest_only=subset(X_test,select= only_mean_and_std_index)
 
 
 
# We    set   the corresponding  labels  to the   measured   variables 
colnames(xtrain_only)=features[only_mean_and_std_index,2]
colnames(xtest_only)=features[only_mean_and_std_index,2]

# In the   following  3 lines  we   merge   all   the   tidy data(tidy train
# and  tidy set) into one  tidy  set called  tidy
tidy_train=cbind(subject_train,y_train,labels_train,xtrain_only)
tidy_test=cbind(subject_test,y_test,labels_test,xtest_only)
tidy=rbind(tidy_test,tidy_train)

# We comput the   average  using mean in the next steps using r vectorization
# and the  function melt  and   dcast  and finally  the script  returns  the 
# so  expected :D  independent tidy data set with the average of each variable 
# for each activity and each subject. 
n=c(names(tidy[1,4:82]))
library(reshape2)
m=melt(tidy,id.vars=c("Subject","Activity_code","Activity_labels"),measure.vars=n)
tidy_mean=dcast(m,Subject+Activity_code+Activity_labels~variable,mean)
tidy_mean
# the result  may  be  found   both in the  file uploaded  and  in a excel  format 
# on google docs  :
#https://docs.google.com/spreadsheets/d/1I4X51Mznair34rjjRE-gDUjxgf_DpdIaCzBnibp8sz4/edit?usp=sharing
 
 
 
 
}
