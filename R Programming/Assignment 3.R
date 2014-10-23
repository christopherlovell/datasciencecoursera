# R programming assignment 3

#data <- read.csv('outcome-of-care-measures.csv')
#head(data)


# 2. Finding the best hospital in a state

best <- function(state,outcome){

  if(missing(state)){ 
    stop("Need to specify state.")
  }
  
  if(missing(outcome)){
    stop("Need to specify outcome.")
  }
  
  # read data
  
  data <- read.csv('outcome-of-care-measures.csv')
  
  outcomes <- c("heart attack","heart failure","pneumonia")
  
  # validate state argument
  
  if(!is.element(state,data[,7])){ 
    stop("invalid state")
  }
  
  if(!is.element(outcome,outcomes)){ 
    stop("invalid outcome")
  }
  
  state_data <- subset(data,State==state)
  
  if(outcome=="heart attack"){
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]
    return(state_data[1,2])
  }
  
  else if(outcome=="heart failure"){
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),]
    return(state_data[1,2])
  }
  
  else if(outcome=="heart attack"){
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),]
    return(state_data[1,2])
  }
  
}



best("TX","heart attack")

