#' Install common packages used in the D6 department
#'
#' @param geo Boolean. Do you intent to process geodata? Installs important geo packages if `TRUE` (the default)
#' 
#' @importFrom utils install.packages
#' @importFrom utils installed.packages
#' @export
install_d6_packages <- function(geo = TRUE) {
  list.of.packages <- c(
    "readr",
    "tibble",
    "dplyr",
    "tidyr",
    "ggplot2",
    "forcats",
    "stringr",
    "purrr",
    "lubridate",
    "here",
    "patchwork",
    "vroom",
    "usethis",
    "credentials"
  )
  if (geo == TRUE) {
    list.of.packages <- c(
      list.of.packages,
      "sf",
      "terra",
      "stars",
      "tmap"
    )
  }
  new.packages <- list.of.packages[!(list.of.packages %in% utils::installed.packages()[,"Package"])]
  if(length(new.packages)) utils::install.packages(new.packages)
}