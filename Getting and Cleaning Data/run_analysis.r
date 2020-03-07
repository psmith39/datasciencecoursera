#Loading Libraries and setting working directory
library(tidyverse)
library(data.table)

#Download Data
setwd("C:/Users/parke/Documents/Data Science Training/Getting and Cleaning Data/Week 4")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "UCI HAR Dataset.zip", mode='wb')
unzip("UCI HAR Dataset.zip")
setwd("./UCI HAR Dataset")
#Load data
  ##Test
  test_set <- read.table("./test/X_test.txt",header=FALSE)
  test_labels <- read.table("./test/Y_test.txt", header=FALSE)
  test_subjects <- read.table("./test/subject_test.txt", header=FALSE)
 
   ##Train
  train_set <- read.table("./train/X_train.txt", header=FALSE)
  train_labels <- read.table("./train/Y_train.txt", header=FALSE)
  train_subjects <- read.table("./train/subject_train.txt", header=FALSE)
  
  ##Extra Info
  features_info <- read.table("./features_info.txt", header=FALSE)
  features <- read.table("./features.txt", header=FALSE)
  activity_labels <- read.table("./activity_labels.txt", header=FALSE)
 
#Merge all Train and Test sets
  combined_set <- rbind(test_set,train_set)
  combined_labels <- rbind(test_labels, train_labels)
  combined_subjects <- rbind(test_subjects, train_subjects)

  ##Renaming Columns in various datasets
  names(activity_labels) <- c("activityid","activity_label")
  names(combined_labels) <- c("activityid")
  names(combined_set) <- features$V2
  names(combined_subjects) <- "subject"  
  ##Combining all data
  combined_labels<- left_join(combined_labels,activity_labels,"activityid")
  combined_set <- cbind(combined_set, combined_labels)
  combined_set <- cbind(combined_set, combined_subjects)

#limit data to only the necessary columns
  ##Figure out which columns are needed
  needed_names <- features$V2[grep("std\\(\\)|mean\\(\\)", features$V2)]
  needed_names <- as.character(needed_names)  
  
  ##select needed data
  final_set <- subset(combined_set,select=c("activity_label","subject",needed_names))
  
#Aggregated table
  agg_set <- final_set %>% group_by(activity_label,subject) %>% summarise_at(vars(-group_cols()),mean)

#Save both datasets 
  write.table(final_set, file = "tidy_set.txt",row.name=FALSE)
  write.table(agg_set, file = "aggregated_set.txt",row.name=FALSE)
                          