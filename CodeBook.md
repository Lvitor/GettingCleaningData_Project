#Introduction

The script `run_analysis.R`
- Need the data from
  [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html) in working directory
- Merges the training and test sets to create one data set
- Replaces `activity` values in the dataset with descriptive activity names
- Appropriately labels the columns with descriptive names
- creates a independent tidy dataset with an average of each variable
  for each each activity and each subject call tiny_dat_by_subj. In other words, same type of
  measurements for a particular subject and activity are averaged into one value
  and the tidy data set contains these mean values only. tiny_dat_by_subj has 563 columns.
- The structu of columns from original for new tiny are this:

* Col_1:  Group.1 - Subject (30 in total)
* Col_2:  Group.2 - Activity that subject are doing 6 possibilities.


- create a file call `tiny_data`

