# Short   description  of the   analysis method  script:

* The  firs part of the script  merges   the  two   dataframes  resulted   by reading  from   train folder and   test  folder
  In this part   I used   R function   read.table and I   got   :
  X_train=data.frame(read.table("X_train.txt"))
  y_train=data.frame(read.table("y_train.txt"))
  I  have set  the  column names  with :
  colnames(y_train)=("Activity_code") and similar  for other  variables
* In  the second   part  of the  script  I   extracted   the measurement   variables  only for the mean  and  std
  I used :
  regular expressions:
  mean_index=grep("(.*)mean(.*)",features[,2])
  std_index=grep("(.*)std(.*)",features[,2])
  to  get  the  indexes  from the  feature  file  where   mean  or  std  occurs.
  I joinde  those indexes:
  only_mean_and_std_index=c(mean_index,std_index)
  and I obtained  subsets  both  for   test and  train :
  xtrain_only=subset(X_train,select= only_mean_and_std_index)
  xtest_only=subset(X_test,select= only_mean_and_std_index)
  I  joined  this data  with  the  appropiate   coresponding  data  and  obtain :
  tidy_train=cbind(subject_train,y_train,labels_train,xtrain_only)
  tidy_test=cbind(subject_test,y_test,labels_test,xtest_only)
  tidy=rbind(tidy_test,tidy_train)
  The  tidy  set represents  the final set   where  we  merged  the  tidy  train set and   tidy test  set.
*In the  next part   I computed  the  tidy  set consisting by  the average of each variable  for each activity and 
each subject. 
 - the  n variable  stores  the  measurement   variables  in  a vectorized way
   n=c(names(tidy[1,4:82]))
 I melted  the  data  using melt   function  from reshape2 library :
 m=melt(tidy,id.vars=c("Subject","Activity_code","Activity_labels"),measure.vars=n)
 and finally  I  computed  the avg with  the  dcast :
 m=melt(tidy,id.vars=c("Subject","Activity_code","Activity_labels"),measure.vars=n)
 
