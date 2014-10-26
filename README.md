GettingAndCleaningDataProject
=============================
Place the script "run_analysis.R" in the "UCI HAR Dataset" folder containing train and 
test folders. Also, set the current directory to "UCI HAR Dataset" folder.
Then you can run the script as follows:
source("runAnalysis.R")


Explanation of written script is as follows:

Step1: Merges the training and the test sets to create one data set
We first read the training data and testing data (subject, activity and 
features) from respective files and merge the columns using "cbind" function.
Then we merge the training data and testing data using "rbind" function.
The dataframe "data" contains the merged data.

Step2: Extracts only the measurements on the mean and standard deviation for 
each measurement
We first read the names of the feature variables from the "features.txt" file.
We then find out the indices of the variable names consisting of "mean()" and 
"std()". 
We select only those indices from the dataframe data and the column subject and 
activity as well.
And we name the columns with the appropraite labels.

Step3: Uses descriptive activity names to name the activities in the data set
We read the "activity_labels.txt" file and label the activities accordingly 
using subsetting.

Step4: Appropriately labels the data set with descriptive variable names
We do some manipulation using "gsub" to label the dataset with descriptive 
variable names.

Step5: From the data set in step 4, creates a second, independent tidy data 
set with the average of each variable for each activity and each subject.
We convert the dataframe to table dataframe using "dplyr" package.
We group the data acc. to "subject" and "activity" and use "summarize_each" 
function to apply "mean" function to rest of the columns. Grouping variables 
are always excluded from modification using "summarize_each" function.


