

# Project Getting and Cleaning Data Course Project
#Langue: français
#Ibrahim KAMATE 
date()

#Instructions:
##réez un script R appelé run_analysis.R qui fait ce qui suit.
# 1. Fusionne les jeux d'entraînement et de tests pour créer un ensemble de données.
# 2. Extrait uniquement les mesures sur la moyenne et l'écart-type pour chaque mesure.
# 3. Utilise des noms d'activité descriptifs pour nommer les activités dans l'ensemble de données.
# 4. Étiqueter correctement l'ensemble de données avec des noms d'activité descriptifs.
# 5. Crée un deuxième ensemble de données ordonnées indépendant avec la moyenne de chaque variable pour chaque activité et chaque sujet.


#Solution
#1. Merges the training and the test sets to create one data set

#Set working directory and check it
setwd("/Users/macbookair/Documents/UCI HAR Dataset")
getwd()


#Read "features.txt" and save as "Featutes" with column names "FeatureId and FeatureName"  # Show numbers of obs and variables
Features <- read.table(".//features.txt", sep="",header=FALSE, col.names=c("FeatureID", "FeatureName")) 
str(Features)

#Read activity labels (activity_labels.txt) and use "ActvityLabelID" and "ActivityLabelName" for column names 
#ActivityLabelNames will be linked with all the ActivityLabel
ActivityLabelNames <- read.table("./activity_labels.txt", sep="", header=FALSE, col.names=c("ActivityLabelID", "ActivityLabelName"))

#TEST data

#Read test set data(X_test.txt), named as testData and use column "FeatureName" of Features as column names # Show numbers of obs and variables
testData <- read.table("./test/X_test.txt", sep="",header=FALSE, col.names=Features$FeatureName )
str(testData)

#Read test activity labels (y_test.txt) and use "ActivityLabelID " for column names # Show numbers of obs and variables
testActivityLabels <- read.table("./test/y_test.txt", sep="",header=FALSE, col.names=c("ActivityLabelID"))
str(testActivityLabels)

#Read test subjects (subject_test.txt) and use SubjectID for column names # Show numbers of obs and variables
testSubjects <- read.table("./test/subject_test.txt", sep="", header=FALSE, col.names=c("SubjectID")) 
str(testSubjects)

#All these data frame have the same number of observation 2947

#TRAIN data

#Read train set  data(X_train.txt), and use column "FeatureName" of the data frame "Features" for column names like X_test # Show numbers of obs and variables
trainData <- read.table("./train/X_train.txt", sep="", header=FALSE, col.names=Features$FeatureName) 
str(trainData)

#Read test activity labels (y_train.txt) and use "ActivityLabelID " for column names like into testActivityLabels# Show numbers of obs and variables
trainActivityLabels <- read.table("./train/y_train.txt", sep="",header=FALSE, col.names=c("ActivityLabelID"))
str(trainActivityLabels)

#Read test subjects (subject_train.txt) and use SubjectID for column names like into testSubjects # Show numbers of obs and variables
trainSubjects <- read.table("./train/subject_train.txt", sep="",header=FALSE, col.names=c("SubjectID")) 
str(trainSubjects)

#All these data frame have the same number of observation 7352

#Perform rbind to testData and trainData to create mergedSetData with the complete observation
mergedSetData <- rbind(testData, trainData)

# Perform rbind to testActivityLabels and trainActiviyLabels to create mergedSetActivityLabels with the complete observation
mergedSetActivityLabels <- rbind(testActivityLabels,trainActivityLabels)

#Perform rbind to testSubjects and trainSubjects to create mergedSetSubjects with the complete observation
mergedSetSubjects <- rbind(testSubjects, trainSubjects)

#Organize the variable "ActivityLabelName" by making it simple and lowercase, then Replace activity label ids with the 6 types of activity label names and call it ActivityLabelName, 
ActivityLabelNames[,2] = gsub("_", "", tolower(as.character(ActivityLabelNames[,2])))
mergedSetActivityLabels[,1] = ActivityLabelNames[mergedSetActivityLabels[,1],2]
#It becomes type instead of ID 
names(mergedSetActivityLabels) <- "ActivityLabelName" 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

#Extract in Features$FeatureName what observation that contains mean or standard deviation(std) without the word Freq, so ...mean()... or ...std()...
#First Observe the result of variable are only about mean and std
observeFeatures <- grep(".*mean()[^Freq]|.*std()", Features$FeatureName,value = TRUE) 
#This variable can be introduce into the new merged of set data
measureFeatures <- grep(".*mean()[^Freq]|.*std()", Features$FeatureName)
#Then add this to the merged set data as a new variable
mergedSubsetData <- mergedSetData[,measureFeatures] 

#3. Uses descriptive activity names to name the activities in the data set

#Add descriptive activity label names in ActivityLabelNames and subject id (SubjectID) to the merged sub data (mergedSubsetData) 
mergedSubsetData$ActivityLabelName <- mergedSetActivityLabels$ActivityLabelName 
mergedSubsetData$SubjectID <- mergedSetSubjects$SubjectID
str(mergedSubsetData)
#We have now 2 more variable in this data , 'data.frame':	10299 obs. of  68 variables

#4. Appropriately labels the data set with descriptive variable names

#Replace columns Names of the subset, 
colnames(mergedSubsetData) <- gsub("\\.+mean\\.+", colnames(mergedSubsetData), replacement=".Mean")
colnames(mergedSubsetData) <- gsub("\\.+std\\.+",  colnames(mergedSubsetData), replacement=".Std")
str(mergedSubsetData)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# Use library data.table to create a data table mergedSubsetDataTable
install.packages("data.table")
library("data.table")

# Create data table mergedSubsetDataTable from mergedSubsetData
mergedSubsetDataTable <- data.table(mergedSubsetData)
str(mergedSubsetDataTable)
# Use columns SubjectID and ActivilityLabelNames of mergedSubsetDataTable to organize the columns of average (mean) data and std 
MeanMergedSubsetData <- mergedSubsetDataTable[, lapply(.SD, mean), by=c("SubjectID", "ActivityLabelName")]

# MeanMergedSubsetData by order of SubjectIDs
MeanMergedSubSetDataa <- MeanMergedSubsetData[order(MeanMergedSubsetData$SubjectID),]

# Write the second data set "MeanMergedSubsetData" to complete the complete the course project
write.table(MeanMergedSubSetDataa, "MeanCleanedDataa.txt", row.names = FALSE) 

