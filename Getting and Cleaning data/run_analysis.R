run_analysis<-function(){
  # Make sure that your working directory is "UCI HAR Dataset" downloaded in the project presentation.
  
  # We are getting the data for the test set.
  
  SubjectTest<-read.table("test/subject_test.txt")
  MeasuresTest<-read.table("test/X_test.txt")
  ActivityTest<-read.table("test/Y_test.txt")
  features<-read.table("features.txt")
  
  # We rename the columns names now as it is necessary to rbind() later.
  
  colnames(SubjectTest)<-"Subjects"
  colnames(ActivityTest)<-"Activities"
  colnames(MeasuresTest)<-features$V2
  
  # We create a dataset combining extracted tables.
  
  datatest<-cbind(SubjectTest,ActivityTest,MeasuresTest)
  datatest<-as.data.frame(datatest)
  
  # We replicate these steps for the train set
  
  SubjectTrain<-read.table("train/subject_train.txt")
  MeasuresTrain<-read.table("train/X_train.txt")
  ActivityTrain<-read.table("train/Y_train.txt")
  
  # We rename the columns names now as it is necessary to rbind() later.
  
  colnames(ActivityTrain)<-"Activities"
  colnames(SubjectTrain)<-"Subjects"
  colnames(MeasuresTrain)<-features$V2
  
  datatrain<-cbind(SubjectTrain,ActivityTrain,MeasuresTrain)
  datatrain<-as.data.frame(datatrain)
  
  # We finally merge these two datasets
  data<-rbind(datatest,datatrain)

  ## QUESTION 2
  # We need to extract only the columns reprenting a mean or standard variation for each measurement.
  # To do that we'll search from features.txt all the lines that have mean() or std() in it, strictly.
  # We get the indices of the column we need, and extract them from data.
  
  data<-data[,grep("Subjects|Activities|mean()[^Freq]|std()",names(data))]

  # By using grep() we are "searching" for the columns names that have mean() or std() in it, but we are 
  # excluding any meanFreq() variables, we don't want them. Of course we are keeping Subjects and Activities variables.
  
  ## Questions 3 & 4
  # Here we change the name of the activities, that were previously referred by a number from 1 to 6.
  data$Activities<-as.character(data$Activities)
  data$Activities<-gsub("1","Walking",data$Activities)
  data$Activities<-gsub("2","WalkingUpstairs",data$Activities)
  data$Activities<-gsub("3","WalkingDownstairs",data$Activities)
  data$Activities<-gsub("4","Sitting",data$Activities)
  data$Activities<-gsub("5","Standing",data$Activities)
  data$Activities<-gsub("6","Laying",data$Activities)
  
  
  # We then change the names of the variables in order to make them more descriptive.
  
  colnames(data)<-gsub("-","",names(data))
  colnames(data)<-gsub("\\(","",names(data))
  colnames(data)<-gsub("\\)","",names(data))
  
  # We use \\ to consider '(' or ')' as the actual parenthesis and not metacharacters.
  # It's difficult to rename completly the variables without loosing meaning in them. We keep the Uppercase letters to improve a little bit visibility.
  # However we can make clear the differences between several variables, as some have a 't' in front of the variable's name and some a 'f'.
  # 't' stands for a variable obtained by time derivated signals and 'f' stands for frequence domain related variable.
  colnames(data)<-gsub("^t","Time",names(data))
  colnames(data)<-gsub("^f","FreqD",names(data))
  
  
  
  ## Question 5
  # For each subject, we are going to determine the average for each measurement for each activity.
  # So we will create a data frame with the subject's number in the rows, so every subject will have 6 rows related to him as for the 6 activities he is doing.
  # For each activity we will calculate the average of the measurements we have.
  # I decided to model that through this function :
  analysis<-function(data){
    res<-NULL
    for (i in 1:30){ # For each subject we gonna calculate the mean of each variable for while doing each activity. Then we are going to combine the results in one single dataset.
      
      tmp<-filter(data,Subjects==i) #Getting all the rows concerning the "i" subject.
      tmp2<-filter(tmp,Activities=="Walking") #Getting all the rows concerning the "i" subject while he is walking.
      front<-tmp2[1,1:2] #"Caching" the 2 first columns as lapply will return an error otherwise.
      res<-rbind(res,cbind(front,lapply(tmp2[,3:dim(tmp2)[2]],function(x) mean(x)))) #Combining the resulting row in res. In the function lapply we get the mean of each variable from all the measurements while doing this activity.
      
      #We do the same for the different activities, and rbind them to res.
      
      tmp2<-filter(tmp,Activities=="WalkingUpstairs")
      front<-tmp2[1,1:2]
      res<-rbind(res,cbind(front,lapply(tmp2[,3:dim(tmp2)[2]],function(x) mean(x))))
      
      tmp2<-filter(tmp,Activities=="WalkingDownstairs")
      front<-tmp2[1,1:2]
      res<-rbind(res,cbind(front,lapply(tmp2[,3:dim(tmp2)[2]],function(x) mean(x))))
      
      tmp2<-filter(tmp,Activities=="Sitting")
      front<-tmp2[1,1:2]
      res<-rbind(res,cbind(front,lapply(tmp2[,3:dim(tmp2)[2]],function(x) mean(x))))
      
      tmp2<-filter(tmp,Activities=="Standing")
      front<-tmp2[1,1:2]
      res<-rbind(res,cbind(front,lapply(tmp2[,3:dim(tmp2)[2]],function(x) mean(x))))
      
      tmp2<-filter(tmp,Activities=="Laying")
      front<-tmp2[1,1:2]
      res<-rbind(res,cbind(front,lapply(tmp2[,3:dim(tmp2)[2]],function(x) mean(x))))
      
    }
    res
  }
  tidydata<-analysis(data)
}
