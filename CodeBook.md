Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  
* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Local name: ucihardataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
 1. Attempt to set working directory to the same location as "run_analysis.R" script. Doing so will make finding output datasets easier.
 2. Download and unzip data from ucihardataset.zip to current working directory if it was not done already.
 3. Load activity file from "UCI HAR Dataset/activity_labels.txt" and decided to go with camelCasing for naming columns after following discussion on http://stackoverflow.com/questions/1944910/what-is-your-preferred-style-for-naming-variables-in-r
 4. Load features file from "UCI HAR Dataset/features.txt" targeting columns containg words "mean" or "std"
 5. Using only target features from step #4, read train datasets from "UCI HAR Dataset/train/" folder and merge them together by column
 6. Using only target features from step #4, read test datasets from "UCI HAR Dataset/test/" folder and merge them together by column
 7. Combine resulting train and test dataframes by row
 8. Assign description column and activity names to merged dataframe (mergedData)
 9. Write "mergedData" dataframe to a flat file "mergedData.txt"
 10. Use ddply function from plyr library to compute means of each measurement based on subject and activity
 11. Write resulting dataframe "averagesData" to a flat file "averagesData.txt"