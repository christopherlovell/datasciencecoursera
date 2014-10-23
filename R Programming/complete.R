complete <- function(directory,id=1:332){
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  masterframe <- data.frame(id=integer(0),nobs=integer(0))
  
  for(i in id){
    # TESTING VALUES
    # i = 1
    # pollutant<-"sulfate"
    # directory<-"specdata"
    
    # add leading zeroes to id value
    format_i <- formatC(i,width=3,format="d",flag="0")    
    
    # create download string
    down_string <- paste("..\\..\\data\\",directory,"\\",format_i,".csv",sep="")
    
    # download the data
    data <- read.table(down_string,sep=",",header=TRUE)
    
    # get subset of complete values
    subsett <- na.omit(data)
    
    newrow <- data.frame(id=i,nobs=length(subsett[[1]]))
    
    masterframe <- rbind(masterframe,newrow)
  }
  masterframe
}

#complete("specdata",30:25)



