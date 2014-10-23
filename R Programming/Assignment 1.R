
pollutantmean <- function(directory,pollutant,id=1:332){
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  # TEST VARIABLES
  directory <- "specdata"
  pollutant <- "sulfate"
  
  # loop through monitors
  for(i in id){
    # TEST VARIABLES
    i <- 1
    
    # add leading zeroes to id value
    format_i <- formatC(i,width=3,format="d",flag="0")    
    
    # create download string
    down_string <- paste(".\\data\\",directory,"\\",format_i,".csv",sep="")
    
    # download the data
    data <- read.table(down_string,sep=",",header=TRUE)
    
    # calculate mean ignoring NA values
    subsett <- na.omit(data[pollutant])
    mean(subsett[[1]])
  }
  
}

