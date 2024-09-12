#'@title Patent Dataset
#'@description This dataset contains 51232 patents from the USPTO database.
#' @format A data frame with 51232 rows and 11 variables:
#' \describe{
#'   \item{\code{guid}}{character. The patent number, a unique identifier.}
#'   \item{\code{inventionTitle}}{character. The title of the patent.}
#'   \item{\code{datePublished}}{POSIXct, date. The date when the patent was published.}
#'   \item{\code{applicationFilingDate}}{character. The date when the patent application was filled.}
#'   \item{\code{inventorsName}}{character. Inventors' names.}
#'   \item{\code{inventorCity}}{character. Inventors' city of residence.}
#'   \item{\code{inventorState}}{character. Inventors' state of residence.}
#'   \item{\code{assigneeName}}{character. Assignees' names.}
#'   \item{\code{assigneeCity}}{character. Assignees' city of residence.}
#'   \item{\code{assigneeState}}{character. Assignees' state of residence.}
#'   \item{\code{cpcInventiveFlattened}}{character. Classifications of the patent.}
#' }
"patent_data"
