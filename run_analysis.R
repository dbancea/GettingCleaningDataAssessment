#
# run_analyses.R - Peer Asseessment -  
#      Merge data from different files
#      Extract columns based on column names
#      Saved the subset of data
#


setwd("D:\\cursuri\\GettingAndCleaningData\\PeerAssessment\\UCI HAR Dataset");

### read metadata
# read activity labels
activity_label <- read.table("activity_labels.txt");

# convert the activity name to character from factor
activity_label$V2 <- as.character(activity_label$V2);

# read features table -> column description for X data
features <- read.table("features.txt");

# convert the features name to character from factor
features$V2 <- as.character(features$V2);


# read the training data
train_x <-  read.table("./train/X_train.txt");
train_y <- read.table("./train/Y_train.txt");
train_subject <- read.table("./train/subject_train.txt");


# read the test data
test_x <-  read.table("./test/X_test.txt");
test_y <- read.table("./test/Y_test.txt");
test_subject <- read.table("./test/subject_test.txt");

### combined the data

## Assignment Part 1: Merges the training and the test sets to create one data set.
merge_x <- rbind(train_x,test_x);

# add the column names
colnames(merge_x) <- features$V2;

## Assignment Part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
merge_x_mean_std <- merge_x[,grep(".*mean\\(\\)|.*std\\(\\)", names(merge_x))];

##Assignment Part 3: Uses descriptive activity names to name the activities in the data set
# The activty description are in the set of Y data: test_Y.txt and train_Y.txt

# merge the train and test Y data
merge_y <- rbind(train_y,test_y);

# add the activity column of character data type
merge_y$activity <- "";

# set the activity description based on the activity class from activity_label
for (i in 1: length(merge_y[,1])) {
  for (j in 1: length(activity_label[,1])) {
    if (merge_y[i,1] == activity_label[j,1]) {
      merge_y[i,2] <- activity_label[j,2];
    }
  }
}

## Assigmnet Part 4: Appropriately labels the data set with descriptive activity names. 

# subset the activity description from merge_y
merge_activity <- merge_y$activity;

# Add the activity description to the mean,std data subset
data_tidy01 <- cbind(merge_activity, merge_x_mean_std);
colnames(data_tidy01)[1] <- c("activity");

## Assignment Part 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Merge the subject data
merge_subject <- rbind(train_subject,test_subject);

# add the subject column to the data_tidy01
data_tidy02 <- cbind(merge_subject, data_tidy01);

# add the column name "subject" for the subject data
colnames(data_tidy02)[1] <- c("subject");

data_final <-aggregate(data_tidy02[, c(3:ncol(data_tidy02))], by=list(data_tidy02$subject,data_tidy02$activity), FUN=mean, na.rm=TRUE);

colnames(data_final)[1] <- c("Group.Subject");
colnames(data_final)[2] <- c("Group.Activity");

write.table(data_final, file = "tidy_data_final.txt");






