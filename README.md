GettingCleaningDataAssessment
=============================

Peer Assessment - Getting and Cleaning Data

run_analysis.R - R code to clean/merge data per assigment requirement
CodeBook.md    - describte the variables and data processing

run_analysis - description
    It is assumed that teh data was downaoded before and uncompressed

- set the working directory
- read the metadata files - activity and features files
- read the observation data for training and test. There are three files, three stes of data:
- combined the train_x and test_x and add the columns name for varbles measured using the features file/data set
- extract only teh columns which have mean and standard deviation
- merger the activity data for test and train and assign teh actvity description to the data
- add teh activity description to the merge data (x set with train and test) resulting data_tidy02 data set
- merger the subject data for train and test and add teh column to teh data_tidy01 resulting data_tidy02 and add teh subject column
- calculate the mean per subject and atctiivty type and teh result is saved in data_final data set
- save the data_final data set in tidy_data_final.txt




