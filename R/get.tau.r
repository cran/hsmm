#############################################
# Calculate the length of observations, tau #
#############################################
get.tau <- function(inputData){
  tau <- as.integer(length(inputData))
  return(tau)
  }
