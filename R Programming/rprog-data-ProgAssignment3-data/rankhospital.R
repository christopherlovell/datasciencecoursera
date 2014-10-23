# R programming assignment 3

#data <- read.csv('outcome-of-care-measures.csv')
#head(data)


# 2. Finding the best hospital in a state

best <- function(state,outcome){

  if(missing(state)){ 
    stop(as.character("Need to specify state."))
  }
  
  if(missing(outcome)){
    stop(as.character("Need to specify outcome."))
  }
  
  # read data
  
  data <- read.csv('outcome-of-care-measures.csv')
  
  outcomes <- c("heart attack","heart failure","pneumonia")
  
  # validate state argument
  
  if(!is.element(state,data[,7])){ 
    stop(as.character("invalid state"))
  }
  
  if(!is.element(outcome,outcomes)){ 
    stop(as.character("invalid outcome"))
  }
  
  state_data <- subset(data,State==state)
  
  if(outcome=="heart attack"){
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,state_data$Hospital.Name),]
  }
  if(outcome=="heart failure"){
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,state_data$Hospital.Name),]
  }
  if(outcome=="pneumonia"){
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,state_data$Hospital.Name),]
  }
  
  return(as.character(state_data[1,2]))
}


# 3. Ranking hospitals by outcome in a state

rankhospital <- function(state,outcome,num = "best"){
  
  if(missing(state)){ 
    stop(as.character("Need to specify state."))
  }
  
  if(missing(outcome)){
    stop(as.character("Need to specify outcome."))
  }
  
  if(missing(num)){
    stop(as.character("Need to specify num."))
  }
  
  
  # read data  
  data <- read.csv('outcome-of-care-measures.csv')
  
  outcomes <- c("heart attack","heart failure","pneumonia")
  
  # validate state argument  
  if(!is.element(state,data[,7])){ 
    stop(as.character("invalid state"))
  }
  
  if(!is.element(outcome,outcomes)){ 
    stop(as.character("invalid outcome"))
  }
  
  state_data <- subset(data,State==state)
  
  # order by given column
  if(outcome=="heart attack"){
    state_data <- state_data[complete.cases(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,state_data$Hospital.Name),] 
  }
  
  if(outcome=="heart failure"){
    state_data <- state_data[complete.cases(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),]
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,state_data$Hospital.Name),]
  }
  
  if(outcome=="pneumonia"){
    state_data <- state_data[complete.cases(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),]
    state_data <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,state_data$Hospital.Name),]
  }
  
  if(num=="best"){
    return(as.character(head(state_data[,2],1)))
  }
  else if(num=="worst"){
    return(as.character(tail(state_data[,2],1)))
  }
  else{
    return(as.character(state_data[num,2],1))
  }
}


output_data <- rankhospital("NC","heart attack","worst")


# 4 Ranking hospitals in all states

rankall <- function(outcome, num){
  
  hospitals <- data.frame()
  names(hospitals) <- c("hospital","state")
  
  if(missing(outcome)){
    stop(as.character("Need to specify outcome."))
  }
  
  if(missing(num)){
    stop(as.character("Need to specify num."))
  }
  
  # read data  
  data <- read.csv('outcome-of-care-measures.csv')
  outcomes <- c("heart attack","heart failure","pneumonia")
  
  if(!is.element(outcome,outcomes)){ 
    stop(as.character("invalid outcome"))
  }
  
  
  
  
}
