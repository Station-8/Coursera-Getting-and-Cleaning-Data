# Coursera-Getting-and-Cleaning-Data
Project work for Getting and Cleaning Data

This repository contains the script and other data files for the assignment.

The objective of the assignment was to take Samsung test and train data files, merge them into a single data frame, merge with header and variables files, and to tidy the resulting data fame for further use.

All of the necessary files are downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The first step was to create a working directory, and read into R the X_test.txt and the X_train.txt files, creating two data frames.

Then the column names, featues.text, were read into R and attached to both data sets.

The test subjects (one for test [subject_test.txt], and one for train [subject_train.txt) were read into R, then added as new columns to the test dataframe and train dataframe, respectively.  Likewise, the activities code numbers for each dataset were read in to R, y_test.txt and y_train.txt, and added as columns to the test dataframe and train dataframe, respectively.

Then the activities descriptions file, activity_labels.txt, were read into R.

Then a column was added to each data frame to denote whethere the data was from "test" or "train"  The column was named "test_or_train" on both data frames so that they could be merged.

The two data frames, test and train, were then merged using rbind command.

At this point the instructions required that the resulting dataframe be subsetted to include only the data elements that included mean or standard deviation. This was done using the grepl() command.  It looked for data column names that contained "mean" or "std".

It was at this point that I converted the activity codes (numbers) to activity descriptions using levels() command.

With this subsetted data, it was time to clean it by putting all column names in lower case, getting rid of any () in column names, replacing "t" prefixed names with "time_", and replacing "f" prefixed names with "fourier_"

The next step was to summarize the means of each datacolumn by activity and by subject.  This was done using the arrange() command from the dplyr package.

The final step was to sort the variable columns first by activity, then by subject.  The result was stored as a dataframe "tidydata".

The "tidydata" dataframe meets the following criteria laid out by the paper "Tidy Data" by Hadley Wickham, published in the Journal of Statistical Software, August 2014, Volume 59, Issue 10:

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

In addition, some housekeeping I did:

4. the column names are all lower case, free of punctuation marks ("-" or "_" ok).
5. the column names are descriptive but not overly lengthy.
6. the variables are descriptive even if they are factors, rather than using number codes.
7. the order of the rows is not random, but by activity and subject.
8. kept the test or train data variable column in case it is needed later.




