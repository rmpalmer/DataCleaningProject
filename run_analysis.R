# this is the script for the final course project for 'Getting and Cleaning Data'
# Richard M. Palmer
# richard.m.palmer@gmail.com
# https://github.com/rmpalmer/DataCleaningProject.git

# for joining...
library(plyr)
library(dplyr)

# for melt and dcast
library(reshape2)

# get a list of the features, used to assign column names when reading data
features <- read.table(file="UCI HAR Dataset/features.txt"
                       ,colClasses = c("integer","character"))

# -- TRAINING --

# read in training data, assigning feature names to the columns
training <- read.table(file="UCI HAR Dataset/train/X_train.txt",col.names=features$V2)

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

# get a mapping of activities (common to training and test)
# this will be used to give descriptive names to the activities
activity_map <- read.table("UCI HAR Dataset/activity_labels.txt"
                           ,colClasses = c("integer","character")
                           ,col.names = c("activity_code","activity_label"))

# map the activity codes to descriptive labels
all_data <- join(all_data,activity_map,by="activity_code")

# get all column names out
all_columns <- names(all_data)

# find the indices of interest
#  with a regular expression looking for .mean. or .std. 
#  or one of the columns that I added in
cols_to_keep <- grep ("(\\.mean\\.|\\.std\\.|subjects|activity_code|activity_label)",all_columns)

# select only the columns of interest
selected_data <- select(all_data,cols_to_keep)

# what are the measurement statistics of interest (ie, only dependent variables)
measurements_of_interest <- grep("(\\.mean\\.|\\.std\\.)",all_columns,value=TRUE)

# make it a narrow tidy dataset
molten <- melt(selected_data
              ,id=c("subjects","activity_label")
              ,measure.vars = measurements_of_interest)

# reshape so that the measurements are all a function of activity and subject
# take the mean of each measurement 
result <- dcast(molten,activity_label + subjects ~ variable, mean)

# write out the dataset as a text file for upload
write.table(result,file="result.txt",row.names = FALSE)

