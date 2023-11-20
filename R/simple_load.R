#' Load Multiple Packages in One Go (and install them if necessary)
#'
#' @param pckgs A vector of packages to load. Packages from CRAN and GitHub can 
#' be passed simultaneously.
#' 
#' @export
#' 
#' @examples simple_load("ggplot2")
#' 
simple_load <- function(pckgs = NULL) {

  ## split packages into cran and github packages
  pckgs_gh   <- grep("/", pckgs, value = TRUE)
  pckgs_cran <- pckgs[!(pckgs %in% pckgs_gh)]
  
  ## install cran packages if needed
  inst_cran <- pckgs_cran %in% installed.packages()
  if(length(pckgs_cran[!inst_cran]) > 0) install.packages(pckgs_cran[!inst_cran])
  
  ## install github package if needed
  inst_gh <- basename(pckgs_gh) %in% installed.packages()
  if (length(pckgs_gh[!inst_gh]) > 0) {
    ## remotes needed to install github packages
    if (!("remotes" %in% installed.packages())) install.packages("remotes")
    remotes::install_github(pckgs_gh[!inst_gh])
  }
  
  ## load packages
  invisible(sapply(basename(pckgs), library, character.only = TRUE, logical.return = TRUE))
}
