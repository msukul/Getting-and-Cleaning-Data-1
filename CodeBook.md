Code Book
========

This is a code book that describes the variables, data, and any transformations or work that you performed to clean up the data.





The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

##### Attribute Information:

For each record in the dataset it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment. 

See Readme file into 'UCI HAR Dataset' for more information.


Raw Data transformation


The raw data sets are processed with the script run_analysis.R script to create a tidy data set.

1. Merge 2 data set
Test and training data, subject ids and activity ids are merged to obtain a single data set. 
Variables are labelled with the names assigned by original collectors.

2. Extract mean &standard deviation variables
Keep only the values of estimated mean and standard deviation .

3.Get activity names
A new column is added to intermediate data set with the activity description.

4.Get label variables appropriately
Labels given from the original collectors were changed to get valid/more descriptive R names 

5.Create a tidy data set
From the intermediate data set is created a final tidy data set where numeric
variables are averaged for each activity and each subject.

Tidy data set


### Variables

The tidy data set contains :
an identifier of the subject who carried out the experiment (__Subject__). Its range is from 1 to 30. 
an activity label (__Activity__): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
mean of all other variables are measurement collected from the accelerometer and gyroscope 3-axial raw signal (numeric value)




The data set is written to the file 'sensordataavgsubject.txt'.
