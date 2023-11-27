#' Load Multiple Packages in One Go (and install them if necessary)
#'
#' @param pckgs A vector of packages to load. Packages from CRAN and GitHub can 
#' be passed simultaneously.
#' @param update_cran Logical. Should CRAN packages be updated? Defaults to FALSE.
#' @param update_gh Logical. Should GitHub packages be updated? Defaults to FALSE.
#' 
#' @export
#' 
#' @examples simple_load("ggplot2")
#' 
simple_load <- function(pckgs = NULL, update_cran = FALSE, update_gh = FALSE) {

  ## split packages into cran and github packages
  pckgs_gh   <- grep("/", pckgs, value = TRUE)
  pckgs_cran <- pckgs[!(pckgs %in% pckgs_gh)]
  
  ## install cran packages if needed
  ## use all CRAN packages if update_cran is TRUE and a subset otherwise
  if (update_cran) { 
    inst_cran <- pckgs_cran 
  } else {
    inst_cran <- pckgs_cran %in% installed.packages() 
  }
  if(length(pckgs_cran[!inst_cran]) > 0) install.packages(pckgs_cran[!inst_cran])
  
  ## install github package if needed
  ## use all GitHub packages if update_gh is TRUE and a subset otherwise
  if (update_gh == FALSE) { 
    inst_gh <- pckgs_gh 
  } else {
    inst_gh <- basename(pckgs_gh) %in% installed.packages()
  }
  if (length(pckgs_gh[!inst_gh]) > 0) {
    ## remotes needed to install github packages
    if (!("remotes" %in% installed.packages())) install.packages("remotes")
    remotes::install_github(pckgs_gh[!inst_gh], force = TRUE)
  }
  
  ## load packages
  invisible(sapply(basename(pckgs), library, character.only = TRUE, logical.return = TRUE))
}
