# GettingCleaningDataAssignment
We are going to describe briefly how we are tidying the data provided by Samsung as the R code is described in the script.
First of all we need to extract the data using the read.table() function.
We extract the features names in features.txt. Then for each set of data, test and train, we extract the subjects number, activities and measurements.
We rename the names of what we have extracted, and then we bind them into one single dataset. To bind the columns we use cbind(), to bind the rows we use rbind(). Rbind() is great for this situation because the two datasets have the same columns' names. So it will just add the rows to one of the dataset.

From that we change the activity labels by coercing the Activities column ,which is a numeric vector, into a character vector. Then we can use the gsub() function to change the numbers according to the activity labels text file provided by Samsung. 
We then remove several characters from the variables' names to provide more clarity for the user.
The variables describe a lot of things and we don't want to loose meaning while renaming them. Therefore we choose to not remove the uppercase() to make them visible. Since it's a data frame we don't want to put a sentence instead of the name variable. Eventhough it could be more descriptive, it will also be very annoying to access the data if someone wants to manipulate them.

We proceed to take the variables with only mean() and std() in their name. Therefore variable name with meanFreq() in it will not be considered. To do that, we use the function grep().

Finally we want a final tidy dataset that is more concise. We create a dataframe that does the following:
Each subject will have 6 rows related to him. Each of the 6 rows will describe an activity. The measurements for each will be the average measurements of the subject while doing a specific activity.
We are going to end up with a nice looking dataset that is concise.
We use a function to do the final step as it is quite redundants steps. The function is described in the R script.

The goal of this assignment is to  get and tidy a bunch of raw datas from a real study.

The features file is from the data provided by Samsung. Our tidy dataset has slightly different names as we removed the parenthesis and the "-" character. We also add "Time" instead of "t" and "FreqD" instead of "f" to emphasis the fact that these variables are not results from the same method.


# Informations about the origin of the data and how it is obtained :

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
