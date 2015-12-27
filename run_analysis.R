url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(url, "data.zip", mode="wb")
files.temp<-"data.zip"
unzip("data.zip")
for (i in files.temp){
  unzip(i)
  }
# getting ready to load test data

currentdr<-getwd()

setwd("UCI HAR Dataset/test") # assumes that only extracted files and directories are here, nothing else
pathname1<-file.path(dir()) # gives 4 strings, where #1 is a directory for Inertial Signals.
subject_test<-read.csv(pathname1[2], header=FALSE, sep="")
X_test<-read.csv(pathname1[3], header=FALSE, sep="")
y_test<-read.csv(pathname1[4], header=FALSE, sep="", stringsAsFactors = FALSE)

# getting ready to load train data
setwd(currentdr) # moves back to starting directory
setwd("UCI HAR Dataset/train") # assumes that only extracted files and directories are here, nothing else
pathname2<-file.path(dir()) # gives 4 strings, where #1 is a directory for Inertial Signals.
subject_train<-read.csv(pathname2[2], header=FALSE, sep="")
X_train<-read.csv(pathname2[3], header=FALSE, sep="")
y_train<-read.csv(pathname2[4], header=FALSE, sep="", stringsAsFactors = FALSE)

setwd(currentdr) # moves back to starting directory

# getting ready to download descriptive data
setwd("UCI HAR Dataset")
pathname3<-file.path(dir()) # gives 6 strings, where #5 and 6 are directories for test and train data
activities<-read.csv(pathname3[1], header=FALSE, sep="", stringsAsFactors = FALSE)
features<-read.csv(pathname3[2], header=FALSE, sep="", stringsAsFactors = FALSE)

rm(pathname1, pathname2, pathname3)
#Step 1. creating one data set

# merging train and test data
y<-rbind(y_test, y_train)
X<-rbind(X_test, X_train)
subject<-rbind(subject_test, subject_train)
rm(y_test, y_train, X_test, X_train, subject_test, subject_train)
# combaining columns

X1<-cbind(X, y, subject) # it seems that this step not used later on
rm(X1)

#Step 2. Extract only mean and standard deviation
library(dplyr)
col_list<-grep("mean", features[,2])  # getting mean column numbers
col_list2<-grep("std", features[,2])  # getting std column numbers
collist<-sort(c(col_list, col_list2)) # combing both lists and sorting in accending order
extracted_data<-select(X, collist)    # extracting columns to new data set called extracted_data


#Step 3.uses descriptive names to name activities

y6<-grep('6',y[,1])  # find lines in y that have 6
y5<-grep('5',y[,1])  # find lines in y that have 5
y4<-grep('4',y[,1])  # find lines in y that have 4
y3<-grep('3',y[,1])  # find lines in y that have 3
y2<-grep('2',y[,1])  # find lines in y that have 2
y1<-grep('1',y[,1])  # find lines in y that have 1


y[y5,]<-activities[grep("5",activities[,1]),2]    #replace lines that have activity #5 in y_renamed to activity name from activity data line #5
y[y4,]<-activities[grep("4",activities[,1]),2]    #replace lines that have activity #4 in y_renamed to activity name from activity data line #4
y[y3,]<-activities[grep("3",activities[,1]),2]    #replace lines that have activity #3 in y_renamed to activity name from activity data line #3
y[y2,]<-activities[grep("2",activities[,1]),2]    #replace lines that have activity #2 in y_renamed to activity name from activity data line #2
y[y1,]<-activities[grep("1",activities[,1]),2]    #replace lines that have activity #1 in y_renamed to activity name from activity data line #1
y[y6,]<-activities[grep("6",activities[,1]),2]    #replace lines that have activity #6 in y_renamed to activity name from activity data line #6
rm(y5,y4,y3,y2,y1,y6)

# Step 4.renaming col names in the extracted dataset
extracted_col_names<-features[collist, 2]   # getting extracted column names
valid_variable_labels <- make.names(extracted_col_names, unique = TRUE, allow_ = TRUE)
names(extracted_data)<-valid_variable_labels
rm(valid_variable_labels, col_list2, col_list, collist, url, i, files.temp)
names(y)<-"activity"
names(subject)<-"subject"
DATA<-cbind(subject, y, extracted_data)  # THe data set with descriptive variable names

# Step 5.

DATA_groupedby<-group_by(DATA, subject, activity)                       # groups data into table by subject(person) than activity
second_dataset<-summarize_each(DATA_groupedby, funs(mean)   )           # creates new table of mean values for all combos of subject and activity

# saving the second data set

setwd(currentdr)                                  # moving back to starting directory
write.table(second_dataset, file = "seconddatafile.txt", row.names = FALSE) # saving the file
rm(extracted_col_names, subject, X, y, features, extracted_data, activities, DATA, DATA_groupedby, currentdr) # deleting other variables

