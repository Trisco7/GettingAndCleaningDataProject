library(dplyr)


#Step1: Merges the training and the test sets to create one data set

trainingDataSubject  <- read.table("train\\subject_train.txt")
trainingDataActivity <- read.table("train\\y_train.txt")
trainingDataFeatures <- read.table("train\\X_train.txt")

testingDataSubject  <- read.table("test\\subject_test.txt")
testingDataActivity <- read.table("test\\y_test.txt")
testingDataFeatures <- read.table("test\\X_test.txt")

trainingData <- cbind(trainingDataFeatures, trainingDataSubject, trainingDataActivity)
testingData  <- cbind(testingDataFeatures, testingDataSubject, testingDataActivity)

data <- rbind(trainingData, testingData)


#Step2: Extracts only the measurements on the mean and standard deviation for 
#each measurement

featuresInfo <- read.table("features.txt")
colnames(featuresInfo) <- c("no", "feature")
featuresInfo <- featuresInfo[, "feature"]

meanIndices <- grep("\\bmean()\\b", featuresInfo)
stdIndices  <- grep("\\bstd()\\b", featuresInfo)
indices <- c(meanIndices, stdIndices)
indices <- sort(indices)

featuresInfo <- featuresInfo[indices]

numCols <- ncol(data)
data <- data[, c(indices, numCols-1, numCols)]
numCols <- ncol(data)
colnames(data) <- c(as.character(featuresInfo), "subject", "activity")


#Step3: Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table("activity_labels.txt")
colnames(activityLabels) <- c("no", "activity")
for (index in 1:nrow(activityLabels))
{
	data[data[, "activity"] == index, numCols] <- as.character(activityLabels[index, "activity"])	
}


#Step4: Appropriately labels the data set with descriptive variable names

colnames(data) <- gsub("-", "", colnames(data))
colnames(data) <- gsub("[(])", "", colnames(data))
colnames(data) <- gsub("mean", "Mean", colnames(data))
colnames(data) <- gsub("std", "Std", colnames(data))
colnames(data) <- gsub("BodyBody", "Body", colnames(data))


#Step5: From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

data <- tbl_df(data)
data <- select(data, subject, activity, 1:(numCols-2))

tidyData <- data %>% group_by(subject, activity) %>%  summarise_each(funs(mean))
write.table(tidyData, file="tidyData.txt", row.names=FALSE)
