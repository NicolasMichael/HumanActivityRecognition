##Getting and Cleaning Data
##Analysis of Human Activity Recoginition using smartphones

###Introduction:

The purpose of this code book is to describe to the analyst the variables, the data and the methodology used to arrive to the final summarised data set that will be used for analysis.

###Raw Data:

The raw data were collected in an experiment carried out with a group of 30 volunteers within an age bracket of 19 – 48 years.
The experiment was carried out by:
*	Jorge L. Reyes-Ortiz,
*	Davide Anguita,
*	Alessandro Ghio,
*	Luca Oneto.

The experiment was carried out in “Smartlab - Non Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova”.
Each person (subject) was asked to carry out six activities:
*	Walking
*	Walking upstairs
*	Walking downstairs
*	Sitting
*	Standing
*	Laying

Each subject was wearing a “Samsung Galaxy S II” on the waist while performing the activities above.  Data were collected about the movement of each subject using the smartphone’s embedded accelerometer and gyroscope.
The obtained data set was partitioned into a training data set (70% of subjects) and a test data set (the remaining 30% of subjects).
The raw data are included in a zip file and can be download from this url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Raw Data Files:

There are four text files and two folders in the zip file:
*	activity_labels.txt
*	features.txt
*	features_info.txt
*	README.txt
*	test (folder)
*	train (folder)

In the folders the following data is available:
*	subjects
*	measurements data set
*	activities data set

For the purposes of this analysis the contents of the folder “Inertial Signals” was not used.

###Process to arrive at the summarised data set:

To arrive at the summarised data set two R functions were used:
*	download_analysis_data.R
*	run_analysis.R

The first function is used to download the raw data.

The second function is used to perform the following transformation to arrive to the summarised data set.

The first step is to load the data set into R:
*	Loads the features list from the relevant text file.  This will be added as column names on the measurements data set.
*	Loads the activities from the relevant text file.  This file contains the activity number and the corresponding activity description.
*	Loads the subjects participating in each partition: training or test.  This file contains the subject number participating.
*	Loads the activities performed in each partition: training or test.  This file contains the activity number.
*	Loads the measurements data set for each partition: training or test.  This file contains all the measurements for each variable included in the features list.

The second step is to merge the general activities list with that activities of each partition.  This allows to link each activity number to each activity description so that the summarised data contains the activity description rather than the activity number.

The third step is to add the features list as column names to the measurements data set, and then subset that measurement data set to the variables of interest.  The variables of interest are related to measurement of the mean and the standard deviation of each activity.

Each record is flagged as being the result of a training activity or test activity in case the analyst needs to distinguish the results.

Then the clean data set of both partitions are combined together to form a clean data set that can be summarised.

The final step was to prepare the summary data set, by calculating the average of each variable by subject and by type of activity performed.

###Variables contained in the summarised data set:
*	Method, flag to indicate the observation source, i.e training or test.
*	Subject, the number of the subject participating in the observation activity.
*	ActivityDesc, the description of the activity performed by the subject.
*	tBodyAcc, the body acceleration time in all axes.
*	tGravityAcc, the gravity time in all axes.
*	tBodyAccJerk, the body acceleration jerk time in all axes.
*	tBodyGyro, the body gyroscope time in all axes.
*	tBodyGyroJerk, the body gyroscope jerk time in all axes.
*	tBodyAccMag, the body acceleration magnitude time.
*	tGravityAccMag, the gravity acceleration magnitude time.
*	tBodyAccJerkMag, the body acceleration jerk magnitude time.
*	tBodyGyroMag, the body gyroscope magnitude time.
*	tBodyGyroJerkMag, the body gyroscope jerk magnitude.
*	fBodyAcc, the body acceleration frequency time in all axes.
*	fBodyAccJerk, the body acceleration jerk frequency in all axes.
*	fBodyGyro, the body gyroscope frequency in all axes.
*	fBodyAccMag, the body acceleration magnitude frequency.
*	fBodyBodyAccJerkMag, the body acceleration jerk magnitude frequency.
*	fBodyBodyGyroMag, the body gyroscope magnitude frequency.
*	fBodyBodyGyroJerkMag, the body gyroscope jerk magnitude frequency.
