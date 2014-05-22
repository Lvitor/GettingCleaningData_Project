Getting and Cleaning Data Course Project
===========================

Script for project of Getting and Cleaning Data - Coursera.

This script need to have unpack the file getdata-projectfiles-UCI HAR Dataset.zip in working directory. You can donwload in  this url:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

TO RUN:
source("run_analysis.R")
run_analysis()

Remember to save run_analysis.r in working directory either.

The main propose of this file are join each of the test and train files in single file with all data. The script also write a copy in working directory for future use. We also provide two more files: 

tiny_dat_by_subj
tiny_data

tiny_dat_by_subj, are basica the X file (with train and test togheter) plus subject, a descript of active with a column head that explain what variable are in each column.


