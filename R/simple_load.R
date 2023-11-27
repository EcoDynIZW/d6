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
  
  
  ## install all listed CRAN packages if update_cran is TRUE, 
  ## otherwise only those that are not yet installed
  if (update_cran) { 
    install.packages(pckgs_cran) 
  } else {
    inst_cran <- pckgs_cran %in% installed.packages() 
    if(length(pckgs_cran[!inst_cran]) > 0) install.packages(pckgs_cran[!inst_cran])
  }
  
  
  ## install all listed GitHub packages if update_gh is TRUE, 
  ## otherwise only those that are not yet installed
  ## if any GitHub packages need to be installed, remotes is installed if needed
  if (update_gh) { 
    if (!("remotes" %in% installed.packages())) install.packages("remotes")
    remotes::install_github(pckgs_gh, force = TRUE) 
  } else {
    inst_gh <- basename(pckgs_gh) %in% installed.packages()
    if (length(pckgs_gh[!inst_gh]) > 0) {
      if (!("remotes" %in% installed.packages())) install.packages("remotes")
      remotes::install_github(pckgs_gh[!inst_gh])
    }
  }
  
  ## load packages (basename() is used to keep only the package name from GitHub inputs)
  invisible(sapply(basename(pckgs), library, character.only = TRUE, logical.return = TRUE))
}
