library(dplyr)

# 1. Merges the training and the test sets to create one data set
trainX <- read.table("ProjectDataset/train/X_train.txt")
testX <- read.table("ProjectDataset/test/X_test.txt")
X <- rbind(trainX, testX)
trainY <- read.table("ProjectDataset/train/y_train.txt")
testY <- read.table("ProjectDataset/test/y_test.txt")
Y <- rbind(trainY, testY)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# get all featured named by mean() and std()
features <- read.table("ProjectDataset/features.txt")
requiredFeatures <- filter(features, grepl("mean\\(", V2) | grepl("std\\(", V2))
# select data by column numbers
data <- select(X, requiredFeatures[,1])

# 3. Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table("ProjectDataset/activity_labels.txt")
labels <- merge(Y, activityLabels)[,2]

# 4. Appropriately labels the data set with descriptive variable names. 
names(data) <- gsub("\\(\\)", "", requiredFeatures[,2])

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# read subjects
trainS <- read.table("ProjectDataset/train/subject_train.txt")
testS <- read.table("ProjectDataset/test/subject_test.txt")
subjects <- rbind(trainS, testS)
# bind activitiy labels and subjects
las <- cbind(labels, subjects)
names(las) <- c("Activity", "Subject")
# bind full data set
alldata <- cbind(data, las)

# summarize the average
summary <- alldata %>% group_by(Activity, Subject) %>% summarize_all(mean)
write.table(summary, "summary.txt", row.name=FALSE)
