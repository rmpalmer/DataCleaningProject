# this is the script for the final course project for 'Getting and Cleaning Data'
# Richard M. Palmer
# richard.m.palmer@gmail.com
# https://github.com/rmpalmer/DataCleaningProject.git

# for joining...
library(plyr)
library(dplyr)

# get a list of the features, used to assign column names when reading data
features <- read.table(file="UCI HAR Dataset/features.txt"
                       ,colClasses = c("integer","character"))

# get a mapping of activities (common to training and test)
activity_map <- read.table("UCI HAR Dataset/activity_labels.txt"
                          ,colClasses = c("integer","character")
                          ,col.names = c("activity_code","activity_label"))

# read in training data, assigning feature names to the columns
training <- read.table(file="UCI HAR Dataset/train/X_train.txt",col.names=features$V2)

# -- TRAINING --
# get the subjects (training)
subjects <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "subjects")

# get the activity code (training)
activity_code <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = "activity_code")

# attach the subject and activity code fields (training)
training <- cbind(training,subjects,activity_code)

# -- TEST --
# read in training data, assigning feature names to the columns
test <- read.table(file="UCI HAR Dataset/test/X_test.txt",col.names=features$V2)

# get the subjects (test)
subjects <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "subjects")

# get the activity code (test)
activity_code <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = "activity_code")

# attach the subject and activity code fields (test)
test <- cbind(test,subjects,activity_code)

# -- ALL_DATA -- 
# merge the training and test data
all_data <- rbind(training, test)

# map the activity codes to labels
all_data <- join(all_data,activity_map,by="activity_code")

