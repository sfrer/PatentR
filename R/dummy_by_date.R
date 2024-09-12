#'@title Create a dummy variable by date.
#'@description This function creates a dummy variable based on date. It will assign 1 to the dummy variable if the date is before the cutoff date.
#'@param data The dataset to use
#'@param date_column The date column to look at. Should be a string.
#'@param cutoff_date The cutoff date. Should be a string or a Date object.
#'@param dummy The name of the dummy variable to create. Should be a string.
#'@return \code{dataset}: The dataset with the new dummy variable.
#'@import tidyverse
#'@export
#'@examples
#'library(patents)
#'library(tidyverse)
#'data('patent_data')
#'x1 = dummy_by_date(patent_data, "datePublished", "2010-01-01", "dummy_date")
#'xx1 = x1[x1$dummy_date == 1,]
#'xx1 = x1[x1$dummy_date != 1,]
#'
#'data = patent_data %>% arrange(datePublished) %>% filter(!is.na(applicationFilingDate))
#'x2 = dummy_by_date(data, "applicationFilingDate", "1900-01-01", "dummy_date")
#'xx2 = x2[x2$dummy_date == 1,]
#'xx2 = x2[x2$dummy_date != 1,]

dummy_by_date = function(data, date_column, cutoff_date, dummy ="dummy_code") {
  if (!inherits(data[[date_column]], "Date")) {
    data[[date_column]] = as.Date(data[[date_column]])
  }
  if (is.character(cutoff_date)) {
    cutoff_date = as.Date(cutoff_date)
  }
  data[[dummy]] = 0
  data[[dummy]][data[[date_column]] < cutoff_date] = 1
  return(data)
}
