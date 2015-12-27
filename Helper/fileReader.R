getInputData <- function(){       
    if (!file.exists("data/Source_Classification_Code.rds") || !file.exists("data/summarySCC_PM25.rds")) {
      writeLines("data source missing, prepare for download Source_Classification_Code.rds")
      downloadZipFile()
    }
	writeLines("geting data")
    NEI <<- readRDS("./data/summarySCC_PM25.rds")
	SCC <<- readRDS("./data/Source_Classification_Code.rds")
}

downloadZipFile <- function(downloadFolder = "./data", downloadUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"){
  #create data folder path if it doesn't exist
  if (!file.exists("data")) {
    dir.create("data")
  }
  
  writeLines(paste("downloading to folder... ", downloadFolder))
  temp <- tempfile()
  download.file(downloadUrl,temp, mode="wb")
  unzip(temp, overwrite = TRUE, exdir = downloadFolder)
  unlink(temp)
}


