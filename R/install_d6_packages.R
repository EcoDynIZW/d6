#' Install common packages used in the D6 department
#'
#' @param geo Boolean. Do you intent to process geodata? Installs important geo packages if `TRUE` (the default)
#' 
#'@export
install_d6_packages <- function(geo = TRUE) {
  list.of.packages <- c(
    "tidyverse", 
    #"lme4",
    #"glmmTMB"
    "usethis",
    "credentials"
  )
  if(geo == TRUE) {
    list.of.packages <- c(
      list.of.packages,
      "rgdal",
      "rgeos",
      "raster",
      "sf"
    )
  }
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
}