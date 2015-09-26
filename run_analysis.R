run_analysis = function(){
  
  library(reshape2)
  
  train = read.table("./train/X_train.txt")
  featuresNames = read.table("./features.txt")
  colnames(train) = paste(featuresNames[,2])
  
  train = train[, grep("mean|std", names(train))]
  trainsub = read.table("./train/subject_train.txt")
  
  #adding the subject to training data
  train$subject = trainsub[,1]
  
  #adding activity labels to training
  
  actsTrain = read.table("./train/y_train.txt")
  train$activity = actsTrain[,1]
  
  test = read.table("./test/X_test.txt")
  colnames(test) = paste(featuresNames[,2])
  
  test = test[, grep("mean|std", names(test))]
  
  testsub = read.table("./test/subject_test.txt")
  
  #adding the subject to testing data
  test$subject = testsub[,1]
  
  #adding the activity labels to the test data
  actsTest = read.table("./test/y_test.txt")
  test$activity = actsTest[,1]
  
  
  #Merging both the data sets
  MergedData = rbind(train,test)
  
  actMap = read.table("./activity_labels.txt")
  
  #adding the activity name column
  for( i in 1 : nrow(MergedData)){
    MergedData$activityName[i] = as.character(actMap[actMap[,1]==MergedData$activity[i],2])
  }
  
  #Now we fix the column names so that they are valid colnames in R
  names(MergedData) = gsub("\\()", "", names(MergedData))
  names(MergedData) = gsub("\\-", "_", names(MergedData))
  
  MeltData = melt(MergedData, id = c("subject", "activityName"), measure.vars = head(names(MergedData), 79))
  
  MeltDataSum = dcast(MeltData, subject + activityName ~ variable, mean)
  
  write.table(MeltDataSum, file = "./tidy_data.txt", col.names = TRUE)
  
  
  
  
  
  
  return(MeltDataSum)
}
