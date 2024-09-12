#'@title Clean the dataset based on a column.
#'@description This function will clean the dataset based on the columns about demographic data, including: \code{inventorState}, \code{assigneeState}, \code{inventorName}, \code{assigneeName}, \code{inventorCity}, and \code{assigneeCity}.
#'If the column is \code{inventorState} or \code{assigneeState}, it will separate the column into multiple rows and clean the duplicates and other countries.
#'@param dataset The dataset to clean.
#'@param column The name of the column to clean. It can be \code{inventorState} or \code{assigneeState}.
#'@return \code{dataset}: The cleaned dataset. Usually have more rows than the original dataset.
#'@import tidyr
#'@export
#'@examples
#'library(patents)
#'data('patent_data')
#'x1=clean_by(patent_data, "inventorState")
#'x2=clean_by(patent_data, "assigneeState")
#'x3=clean_by(patent_data, "inventorsName")
#'x4=clean_by(patent_data, "assigneeName")
#'x5=clean_by(patent_data, "inventorCity")
#'x6=clean_by(patent_data, "assigneeCity")

clean_by=function(dataset, column){
  # create a dataset by separating the inventorState column into multiple rows
  # prepare for analysis of states
  require(tidyr)
  new_set=dataset
  new_set[[column]] <- gsub("\\[|\\]", "", new_set[[column]])
  new_set[[column]] <- gsub("'", "", new_set[[column]])
  new_set = separate_rows(new_set, column, sep=', ', convert = TRUE)

  if (column=="inventorState" | column=="assigneeState"){
    # clean duplicates
    new_set[[column]][new_set[[column]]=="CA 91106"]="CA"
    new_set[[column]][new_set[[column]]=="MT 59829"]="MT"
    new_set[[column]][new_set[[column]]=="N/A"]=NA

    # other countries
    new_set[[column]][new_set[[column]]=="NB"]=NA
    new_set[[column]][new_set[[column]]=="PR"]=NA
    new_set[[column]][new_set[[column]]=="CH"]=NA
    new_set[[column]][new_set[[column]]=="GB2"]=NA
    new_set[[column]][new_set[[column]]=="Attorney at Law 1041"]=NA
    new_set[[column]][new_set[[column]]=="US"]=NA
  }
  return(new_set)
}
