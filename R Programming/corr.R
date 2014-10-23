
corr <- function(directory, threshold=0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  # TEST VALUES
  # directory <- "specdata"
  
  # set path directory
  pathdir <- paste("..\\..\\data\\",directory,sep="")
  
  # find number of files in given directory
  fileno <- length(list.files(path=pathdir))
  
  # find completion statistics for each files
  compstats <- complete(directory,1:fileno)
  
  # initialise return vector
  corvector <- vector(mode="integer")
  
  for(i in 1:fileno){
    if(compstats[i,2]>threshold){
      # TEST VARIABLES
      # i <- 2
      
      # add leading zeroes to id value
      format_i <- formatC(i,width=3,format="d",flag="0")    
      
      # create download string
      down_string <- paste("..\\..\\data\\",directory,"\\",format_i,".csv",sep="")
      
      # get the data
      data <- read.table(down_string,sep=",",header=TRUE)
      
      # find correlation vector for complete cases
      corvector <- c(corvector,cor(data[,2],data[,3],use="na.or.complete"))
    }
    else{
      # do nothing
    }
  }
  
  corvector
}

# TESTS

# cr<-corr("specdata",threshold=150)
# head(cr)
# summary(cr)
# 
# cr <- corr("specdata", 400)
# head(cr)
# summary(cr)
# 
# cr <- corr("specdata", 5000)
# summary(cr)
# 
# length(cr)
# 
# cr <- corr("specdata")
# summary(cr)
# 
# length(cr)

