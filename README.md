# Readme
# Project Getting and Cleaning Data Course Project
#Langue: français
# Ibrahim KAMATE 


# Instructions:
# Créez un script R appelé run_analysis.R qui fait ce qui suit.
# 1. Fusionne les jeux d'entraînement et de tests pour créer un ensemble de données.
# 2. Extrait uniquement les mesures sur la moyenne et l'écart-type pour chaque mesure.
# 3. Utilise des noms d'activité descriptifs pour nommer les activités dans l'ensemble de données.
# 4. Étiqueter correctement l'ensemble de données avec des noms d'activité descriptifs.
# 5. Crée un deuxième ensemble de données ordonnées indépendant avec la moyenne de chaque variable pour chaque activité et chaque sujet.


# Solution
# 1. Merges the training and the test sets to create one data set

#Set working directory and check it
#Read "features.txt" and save as "Featutes" with column names "FeatureId and FeatureName"  # Show numbers of obs and variables
#Read activity labels (activity_labels.txt) and use "ActvityLabelID" and "ActivityLabelName" for column names 
#ActivityLabelNames will be linked with all the ActivityLabel

#TEST data
#Read test set data(X_test.txt), named as testData and use column "FeatureName" of Features as column names # Show numbers of obs and variables
#Read test activity labels (y_test.txt) and use "ActivityLabelID " for column names # Show numbers of obs and variables
#Read test subjects (subject_test.txt) and use SubjectID for column names # Show numbers of obs and variables
#All these data frame have the same number of observation 2947

#TRAIN data
#Read train set  data(X_train.txt), and use column "FeatureName" of the data frame "Features" for column names like X_test # Show numbers of obs and variables
#Read test activity labels (y_train.txt) and use "ActivityLabelID " for column names like into testActivityLabels# Show numbers of obs and variables
#Read test subjects (subject_train.txt) and use SubjectID for column names like into testSubjects # Show numbers of obs and variables
#All these data frame have the same number of observation 7352

#Perform rbind to testData and trainData to create mergedSetData with the complete observation
#Perform rbind to testActivityLabels and trainActiviyLabels to create mergedSetActivityLabels with the complete observation
#Perform rbind to testSubjects and trainSubjects to create mergedSetSubjects with the complete observation

#Organize the variable "ActivityLabelName" by making it simple and lowercase, then Replace activity label ids with the 6 types of activity label names and call it ActivityLabelName, 
#It becomes type instead of ID 


# 2. Extracts only the measurements on the mean and standard deviation for each measurement

#Extract in Features$FeatureName what observation that contains mean or standard deviation(std) without the word Freq, so ...mean()... or ...std()...
#First Observe the result of variable are only about mean and std
#This variable can be introduce into the new merged of set data
#Then add this to the merged set data as a new variable

# 3. Uses descriptive activity names to name the activities in the data set

#Add descriptive activity label names in ActivityLabelNames and subject id (SubjectID) to the merged sub data (mergedSubsetData) 
#We have now 2 more variable in this data , 'data.frame':	10299 obs. of  68 variables

# 4. Appropriately labels the data set with descriptive variable names
#Replace columns Names of the subset, 

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
#Use library data.table to create a data table mergedSubsetDataTable
#Create data table mergedSubsetDataTable from mergedSubsetData
#Use columns SubjectID and ActivilityLabelNames of mergedSubsetDataTable to organize the columns of average (mean) data and std 
#MeanMergedSubsetData by order of SubjectIDs
#Write the second data set "MeanMergedSubsetData" to complete the complete the course project




==================================================================
Reference Data Set:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 



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
