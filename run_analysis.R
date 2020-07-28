filename <- "Coursera_DS3_Final.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
#1st task
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged <- cbind(subject, y, x)
#2nd task
extracted_msd <- merged %>%
  select(subject, code, contains("mean"), contains("std"))
#3rd task
extracted_msd$code <- activities[extracted_msd$code, 2]
#4th task
names(extracted_msd)[2] = "activity"
names(extracted_msd)<-gsub("Acc", "Accelerometer", names(extracted_msd))
names(extracted_msd)<-gsub("Gyro", "Gyroscope", names(extracted_msd))
names(extracted_msd)<-gsub("BodyBody", "Body", names(extracted_msd))
names(extracted_msd)<-gsub("Mag", "Magnitude", names(extracted_msd))
names(extracted_msd)<-gsub("^t", "Time", names(extracted_msd))
names(extracted_msd)<-gsub("^f", "Frequency", names(extracted_msd))
names(extracted_msd)<-gsub("tBody", "TimeBody", names(extracted_msd))
names(extracted_msd)<-gsub("-mean()", "Mean", names(extracted_msd), ignore.case = TRUE)
names(extracted_msd)<-gsub("-std()", "STD", names(extracted_msd), ignore.case = TRUE)
names(extracted_msd)<-gsub("-freq()", "Frequency", names(extracted_msd), ignore.case = TRUE)
names(extracted_msd)<-gsub("angle", "Angle", names(extracted_msd))
names(extracted_msd)<-gsub("gravity", "Gravity", names(extracted_msd))
#5th task
indy_data <- extracted_msd %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))
write.table(indy_data, "indy_data.txt", row.names = FALSE)
#check
str(indy_data)
indy_data
