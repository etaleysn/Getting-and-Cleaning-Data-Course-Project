Getting and Cleaning Data Course Project
========================================
This file describes how run_analysis.R script works.
* Use source("run_analysis.R") command. 
* You will find two output files are generated in the current working directory:
  - mergedData.txt (7.9 Mb): it contains a data frame called mergedData with 10299*68 dimension.
  - averagesData.txt (220 Kb): it contains a data frame called averagesData with 180*68 dimension. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features. 