#'@title Create a dummy variable based on a condition.
#'@description This function creates a dummy variable based on a condition. It is useful to create a dummy variable for a specific word in a column.
#'@param data The dataset to use
#'@param condition The condition to look for. Should be a string.
#'@param col The name of the column to look at. Should be a string.
#'@param dummy The name of the dummy variable to create. Should be a string.
#'@return \code{dataset}: The dataset with the new dummy variable.
#'@export
#'@examples
#'library(patents)
#'data('patent_data')
#'x1=dummy_by_condition(patent_data, "michael", "inventorsName", "michael_dummy")
dummy_by_condition=function(data, condition, col, dummy ="dummy_code"){
  data[[dummy]] = as.integer(grepl(condition, data[[col]], ignore.case = TRUE))
  return(data)
}
