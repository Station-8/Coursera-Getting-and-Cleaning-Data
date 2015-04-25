## put all files to be used in a single working directory file
## set working directory
setwd("~/Desktop/Coursera/Getting Cleaning/Project/Projectfolder")
## read test and train data into R and assign variable names
Xtestdata <- read.table("X_test.txt")
Xtraindata <- read.table("X_train.txt")
## assign column names to Xtestdata
## first, read features.txt file into R
data_column_names <- read.table("features.txt")
## convert data_table_names into a vector
column_names <- as.vector(data_column_names[ ,2])
## assign column names to Xtestdata
colnames(Xtestdata) <- column_names
## assign column names to Xtraindata
colnames(Xtraindata) <- column_names
## add a column to both datasets to indicate whether test or training data
## not sure whether this is necessary, but decided to preserve this information
tryXtestdata <- cbind("test", Xtestdata)
tryXtraindata <- cbind("train", Xtraindata)
## assign new column name "test or train" to this column for both data sets
colnames(tryXtestdata)[1] <- "test_or_train"
colnames(tryXtraindata)[1] <- "test_or_train"
## read into R the subject numbers for the test and train datasets from subject_test.txt and subject_train.txt files
subjecttest <- scan("subject_test.txt", what = "numeric")
subjecttrain <- scan("subject_train.txt", what = "numeric")
## read into R the activities_labels.txt file
activities <- read.table("activity_labels.txt")
# add subject column to both data sets
subXtestdata <- cbind(subjecttest, tryXtestdata)
subXtraindata <- cbind(subjecttrain, tryXtraindata)
## change the subject column names in both data sets to "subject"
colnames(subXtestdata)[1] <- "subject"
colnames(subXtraindata)[1] <- "subject"
## read into R the activities codes for test and train, to eventually cbind with respective data frames
activities_test <- scan("y_test.txt", what = "numeric")
activities_train <- scan("y_train.txt", what = "numeric")
## now bind the activities codes to both data sets
test_data_set <- cbind(activities_test, subXtestdata)
train_data_set <- cbind(activities_train, subXtraindata)
## change the column name for activities to "activity" for both data sets
colnames(test_data_set)[1] <- "activity"
colnames(train_data_set)[1] <- "activity"
## combine the two sets of data test_data_set and train_data_set into dataframe called "full_data"
full_data <- rbind(test_data_set, train_data_set)
## subset full data to include only columns with mean ("mean") or std deviation ("std")
data_sub <- full_data[ ,grepl("activity", names(full_data))|grepl("subject", names(full_data))|grepl("test_or_train", names(full_data))|grepl("mean", names(full_data))|grepl("std", names(full_data))]
## convert activities codes data in column 1 to desctiptions
levels(data_sub$activity) <- activities[ ,2]
## convert activity descriptions data to lower case
data_sub$activity <- tolower(data_sub$activity)
## remove () from all data column names
names(data_sub) <- gsub("\\(\\)","", names(data_sub))
## put all names in lower case
names(data_sub) <- tolower(names(data_sub))
## change "t" prefixes in data column names to "time_"
names(data_sub) <- sub("tb","time_b", names(data_sub))
names(data_sub) <- sub("tg","time_g", names(data_sub))
## change "f" prefixes in data column names to "fourier_" 
names(data_sub) <- sub("fb","fourier_b", names(data_sub))
## now calculate the means by subject and by activity using aggregate function
## this should result in 180 rows of data (30 subjects x 6 activities)
dataaggdata <- aggregate(. ~ activity + subject + test_or_train, data = data_sub, FUN = mean)
# let's look at the top three rows:
head(dataaggdata, n = 3)
## and the bottom three rows:
tail(dataaggdata, n = 3)
## we at least can see that each of these rows has a different activity and subject
## looking at the dimensions of the dataframe, it has right number of rows
## with str() command, we can see that all of the data columns are there.
str(dataaggdata)
## now all that's left is to tidy up the sort order of the subject and activity rows.
## it may be more interesting to see by activity, then by subject.
## load dplyr
## use dplry arrange command
library(dplyr)
tidydata <- arrange(dataaggdata, activity, subject)
## dataframe is now organized by activity and by subject. Test or train data preserved.
head(tidydata, n = 4)
## the "tidydata" dataframe meets the following criteria for tidy data.
## 1. each observation is on one row.
## 2. each column has one reading
## 3. the column names are all lower case, free of punctuation marks ("-" or "_" ok)
## 4. the column names are descriptive but not overly lengthy
## 5. the variables are descriptive even if they are factors
## 6. the order of the rows is not random, but by activity and subject
## 7. kept the test or train data in case it is needed later
