#'@title Check the frequency of a column.
#'@description This function will check the frequency of a column in the dataset. By default, the function gives a frequency table in decreasing order.
#'@param dataset The dataset to use.
#'@param column The name of the column to look at.
#'@param decreasing A logical value to determine the order of the frequency table. Default to TRUE.
#'@param graph A logical value to determine whether to plot the frequency table. Default to TRUE.
#'@param num The number of top items to plot. Default to 10.
#'@param fill The color to plot. Default to pink.
#'@return \code{dataset}: The frequency table of the column.
#'@import ggplot2
#'@export
#'@examples
#'library(patents)
#'data('patent_data')
#'x1=clean_by(patent_data, "assigneeCity")
#'x1=check_frequency(x1, "assigneeCity")
check_frequency=function(dataset, column, decreasing=T, graph=TRUE, fill='pink', num=10){
  freq_table=as.data.frame(sort(table(dataset[[column]]),decreasing=decreasing))
  colnames(freq_table)=c(column,"frequency")
  if (graph==TRUE){
    if (!require(ggplot2)){
      stop('Install ggplot2 first. ')
    }
    plot=ggplot(freq_table[1:num, ], aes(x=.data[[column]], y=frequency)) +
      geom_bar(stat="identity", fill=fill) +
      theme_minimal()
    print(plot)
  }
  return(freq_table)
}

