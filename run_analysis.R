run_analysis <- function(){
        
        ## Set up variables for navigating to the text files
        
        ## General data
        mainPath <- "UCI HAR Dataset.zip"
        activitiesListPath <- "UCI HAR Dataset/activity_labels.txt"
        featuresListPath <- "UCI HAR Dataset/features.txt"
        ## Training data
        trainActivitiesPath <- "UCI HAR Dataset/train/y_train.txt"
        trainSubjectsPath <- "UCI HAR Dataset/train/subject_train.txt"
        trainDataPath <- "UCI HAR Dataset/train/X_train.txt"
        ## Test data
        testActivitiesPath <- "UCI HAR Dataset/test/y_test.txt"
        testSubjectsPath <- "UCI HAR Dataset/test/subject_test.txt"
        testDataPath <- "UCI HAR Dataset/test/X_test.txt"
        
        ## Check if the file exists, if not warn user
        if(!file.exists(mainPath)){
                stop("Cannot find UCI HAR Dataset.zip in your working directory.
                     You can download it from this address:
                     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
                     Optionally use the function download_analysis_data.R to download the zip file."
                     )
        }
        else{
                ## Load general lists
                activitiesList <- read.table(unz(mainPath, activitiesListPath), header=FALSE, sep="", col.names=c("ActivityID", "ActivityDesc"))
                featuresList <- read.table(unz(mainPath, featuresListPath), header=FALSE, sep="")
                        
                ## Load Train data
                trainDataAll <- read.table(unz(mainPath, trainDataPath), header=FALSE, sep="", col.names=featuresList[,2], check.names=FALSE)
                trainActivities <- read.table(unz(mainPath, trainActivitiesPath), header=FALSE, sep="", col.names="ActivityID")
                trainSubjects <- read.table(unz(mainPath, trainSubjectsPath), header=FALSE, sep="", col.names="Subject")
                
                ## Finalise Training data subset
                
                ## Flag Training data subset, could be useful in later analysis
                Method <- "Train"
                
                ## Add Activity Desc In trainActivities
                trainActivities <- merge(trainActivities, activitiesList, by="ActivityID")
                ActivityDesc <- trainActivities[,2]
                
                ## Subset training data with columns of interest: mean, std
                trainData <- trainDataAll[, grep('mean()|std()', names(trainDataAll))]
                
                ## Finalise training subset: add flag, subject column and activity desc column
                cleanTrainData <- cbind(ActivityDesc, trainData)
                cleanTrainData <- cbind(trainSubjects, cleanTrainData)
                cleanTrainData <- cbind(Method, cleanTrainData)
                
                ## Load Test Data
                testDataAll <- read.table(unz(mainPath, testDataPath), header=FALSE, sep="", col.names=featuresList[,2], check.names=FALSE)
                testActivities <- read.table(unz(mainPath, testActivitiesPath), header=FALSE, sep="", col.names="ActivityID")
                testSubjects <- read.table(unz(mainPath, testSubjectsPath), header=FALSE, sep="", col.names="Subject")
                
                ## Finalise Test data subset
                
                ## Flag Training data subset, could be useful in later analysis
                Method <- "Test"
                
                ## Add Activity Desc In testActivities
                testActivities <- merge(testActivities, activitiesList, by="ActivityID")
                ActivityDesc <- testActivities[,2]
                
                ## Subset test data with columns of interest: mean, std
                testData <- testDataAll[, grep('mean()|std()', names(testDataAll))]
                
                ## Finalise test subset: add subject column and activity desc column
                cleanTestData <- cbind(ActivityDesc, testData)
                cleanTestData <- cbind(testSubjects, cleanTestData)
                cleanTestData <- cbind(Method, cleanTestData)
                
                ## Merge train subset and test subset
                cleanSet <- cleanTrainData
                cleanSet <- rbind(cleanTestData, cleanSet)
                
                ## Summarise the combined data set: calculate the mean of each
                ## Subject for each Activity for each Variable
                ## Note: calculate the mean of all columns except those added
                ## during the process: Method Flag, Subject and Activity Description
                cleanSumData <- aggregate(cleanSet[, 4: ncol(cleanSet)], by=list(Method=cleanSet$Method, Subject=cleanSet$Subject, Activity=cleanSet$ActivityDesc), FUN=mean)
                
                ## Order clean summarised data set by Subject then by Activity
                cleanSumData <- cleanSumData[order(cleanSumData$Subject, cleanSumData$Activity), ]
                
                ## Write clean summarised data set to file
                write.table(cleanSumData, file="HAR Summarised Data.txt", quote=FALSE, sep=" ", row.names=FALSE, col.names=TRUE)
                
                ## Notify user of process end
                return("Processing Complete. Please find the results in your working directory: HAR Summarised Data.txt")
        }
}
