#'@title Check the frequency of a column by groups.
#'@description This function will check the frequency of a column by groups in the dataset.
#'By default, the function gives a frequency table in decreasing order.
#'The function also plots the frequency table by groups.
#'@param dataset The dataset to use.
#'@param column The name of the column to look at.
#'@param decreasing A logical value to determine the order of the frequency table. Default to TRUE.
#'@param graph A logical value to determine whether to plot the frequency table. Default to TRUE.
#'@param group The name of the column to group by.
#'@param fill The color to plot. Default to pink.
#'@param num The number of top items to plot. Default to 10.
#'@import ggplot2
#'@import dplyr
#'@return \code{freq_list}: A list of frequency tables for each group.
#'@export
#'@examples
#'library(patents)
#'data('patent_data')
#'x1=clean_by(patent_data, "inventorState")
#'x1=freq_by_group(x1, "inventorState", "inventorsName", graph=FALSE)
freq_by_group=function(dataset, group, column, decreasing=TRUE, graph=TRUE, num=10, fill='pink'){
  # goal: take in a dataset and return the frequency of the specified column for each group
  # input: dataset: the dataset to look at
  #        group(chr): the column to group by
  #        column(chr): the column to look at
  #        graph: whether to plot the frequency table
  #        num: the number of top items to plot
  # designed for inventorState, assigneeName, and inventorName
  # output: a dataframe with the frequency of the specified column for each group
  require(dplyr)
  require(ggplot2)
  require(rlang)
  # split groups
  group=sym(group)
  group=enquo(group)
  dataset_list=dataset %>% group_by(!!group) %>% group_split()

  # frequency table list
  freq_list=list()
  for (i in 1:length(dataset_list)){
    df=dataset_list[[i]]
    ta=as.data.frame((sort(table(df[[column]]),decreasing=T)))
    freq_list[[as.character(df[[as.character(group)[[2]]]][i])]]=ta
  }

  # graph
  if (graph==TRUE){
    for (i in 1:length(freq_list)){
      if (nrow(as.data.frame(freq_list[[i]]))>num){
        plot=ggplot(as.data.frame(freq_list[[i]][1:num,]), aes(x=reorder(Var1, Freq), y=Freq)) +
          geom_bar(stat="identity", fill=fill) +
          coord_flip()+
          labs(title = paste('Top',as.character(num), column,'for', names(freq_list)[i]),
               x = column,
               y = "Frequency")+
          theme_minimal()
        print(plot)
      }
    }
  }
  return(freq_list)
}

