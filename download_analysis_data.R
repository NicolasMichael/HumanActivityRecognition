download_analysis_data <- function(){
        
        ## Download the data files in user's working directory.
        
        if(file.exists("UCI HAR Dataset.zip")){
                stop("The file UCI HAR Dataset.zip already exists!")
        }
        else{
                ## Download the zip file in the working directory.
                zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(zipUrl, "UCI HAR Dataset.zip")        
        }
}