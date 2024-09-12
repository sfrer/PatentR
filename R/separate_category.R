#'@title Separate the category column into multiple columns.
#'@description This function serves a special purpose to separate the category \code{cpcInventiveFlattened} column into multiple columns.
#'@param dataset The dataset to use.
#'@return \code{dataset}: A dataset with the category column separated into multiple columns.
#'@export
#'@import dplyr
#'@import stringr
#'@examples
#'library(patents)
#'data('patent_data')
#'x1=separate_category(patent_data)
separate_category=function(dataset){
  # take the dataset and separate the category column into multiple rows
  # input: dataset: the dataset to look at
  # output: a dataset with the category column separated into multiple rows
  require(stringr)
  require(dplyr)
  # Step 1: Split `code` into multiple rows wherever there is a `;`
  df_split <- dataset %>%
    separate_rows(cpcInventiveFlattened, sep = ";")
  # Step 2: Extract components into new columns
  pattern <- "([A-Z])(\\d+)([A-Z])(\\d+)/(\\d+)"
  # Apply str_match to extract parts and create a new data frame with these parts
  df_parts <- df_split %>%
    mutate(Parts = str_match(cpcInventiveFlattened, pattern)) %>%
    # Convert the matrix into separate columns
    mutate(category = Parts[,2], sub_category_1st = Parts[,3], sub_category_2nd = Parts[,4], sub_category_3rd = Parts[,5], sub_category_4th = Parts[,6]) %>%
    # Select and arrange the final columns, removing the intermediate 'Parts' column
    select(-Parts)
  return(df_parts)
}
