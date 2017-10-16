library(dplyr)

# Set the root directory to where data archive was unzipped
dataRootDir <- "UCI HAR Dataset"


# Read the activity names
activityNames <- 
    read.table(paste(dataRootDir, "activity_labels.txt", sep = "/"), col.names = c("Activity.Id", "Activity.Name"))


# Read and clean up the variable names into column worthy names
variableNames <- 
    read.table(paste(dataRootDir, "features.txt", sep = "/"), col.names = c("Variable.Id", "Variable.Name.Raw")) %>% 
    mutate(Variable.Name =  gsub("-|,", ".", gsub("\\(\\)", "", Variable.Name.Raw))) %>% 
    select(Variable.Id, Variable.Name)


# A function for reading in and assembling one of these datasets from the structured data
readDataset <- function(datasetName) {
    # Read the subject id column
    subjectFilePath <- file.path(dataRootDir, datasetName, paste("subject_", datasetName, ".txt", sep=""))
    subjectIds <- read.table(subjectFilePath, col.names = c("Subject.Id"))
    
    # Read the activity id column, merge in the activity names and drop the activity id
    activityFilePath <- file.path(dataRootDir, datasetName, paste("y_", datasetName, ".txt", sep=""))
    activityIds <- read.table(activityFilePath, col.names = c("Activity.Id"))
    activities <- merge(activityIds, activityNames) %>% select(Activity.Name)
    
    # Read the variable values, filtering for only "mean" and "std" columns
    variableDataFilePath <- file.path(dataRootDir, datasetName, paste("X_", datasetName, ".txt", sep=""))
    variableData <- read.table(variableDataFilePath, col.names = variableNames$Variable.Name)
    variableData <- variableData[, grep("\\.mean\\.|\\.std\\.", names(variableData))]
    
    # Bind the columns together, returning the resulting data frame
    cbind(subjectIds, activities, variableData)
}

trainData <- readDataset("train")

testData <- readDataset("test")

# Combine the train and test data sets and calculate averages grouped subject and activity
finalData <- rbind(trainData, testData) %>% group_by(Subject.Id, Activity.Name) %>% summarise_all(funs(mean))

# Write out the final data
write.table(finalData, "final_data.txt", row.names = FALSE)

