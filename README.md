# Getting and Cleaning Data Course Project

End of course project by Richard M. Palmer

## run_analysis.R script

This script does the following:

* load necessary libraries
* Get a list of all features from the file features.txt
* Read in all the measurements for the training data from the file
X_train.txt
* Read the subjects from subject_train.txt and append this to the measurements
* Read the activity codes from y_train.txt and append this to the measurements
* Read in all the measurements for the test data from the file
X_test.txt
* Read the subjects from subject_test.txt and append this to the measurements
* Read the activity codes from y_test.txt and append this to the measurements
* Row bind the training and test dataests together
* Get a map of integer activity codes to label strings from the file
activity_labels.txt
* use join to add the activity labels from the map to each row
* strip off the names of all columns
* find the column indices of measurements to keep by grep on the
vector of column names.  Also include the subject, activity label,
and activity code columns
* use the resulting column indices to select data to keep
* again using grep, find the names of measurements of interest
* melt the dataset into a narrow tidy frame with one measurement per row
* use dcast to reshape the dataframe so that each row is a unique
combination of activity and subject.  Use the mean function to collect
all measurements for each such combination.
* write out the resulting data frame as a text file.

## Resulting data

The resulting data are 180 rows with 68 columns.
Each row represents a different combination of activity and subject.
The first two columns give the activity label and subject.
The remaining columns give the mean of the measurements for that
particular combination of activity and subject.
The codebook is in a separate file.

## The following command can be used to load the resulting data

data <- read.table(file="result.txt",header=TRUE)
