# GCD_Course_Project
Getting and cleaning data course project repository

The program run_analysis.R takes the values given in the training and test datasets and merges them. Then it filters out all the variables that do not contain the texts 'mean' or 'median' as required by the course project.

Once we have the required columns, the program melts the data set so that all the values are grouped by the primary keys i.3. subject numbers and the activity name.

The last part involves using 'dcast' to take the mean of all the activities for a particular subject for all 6 activities that have been tested.
