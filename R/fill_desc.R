#' Fill your description
#'
#' @param pkg_title Full title of the package
#' @param pkg_description Description of the package
#' @param author_first_name First Name of the author
#' @param author_last_name Last Name of the author
#' @param author_email Email of the author
#' @param pkg_version package version
#' @param repo_url URL (if needed)
#' 
#' @importFrom desc description
#' @importFrom cli cat_bullet
#' @importFrom fs path path_abs
#' #' @importFrom here here
#' @export
if_not_null <- function(x, ...){
  if (! is.null(x)){
    force(...)
  }
}

fill_desc <- function(
  pkg_title,
  pkg_description,
  author_first_name, 
  author_last_name, 
  author_email, 
  pkg_version,
  repo_url = NULL,
  pkg = here::here()
){
  
  path <- path_abs(pkg)
  
  desc <- desc::description$new(
    file = path(path, "DESCRIPTION")
  )
  
  desc$set(
    "Authors@R", 
    sprintf(
      "person('%s', '%s', email = '%s', role = c('cre', 'aut'))", 
      author_first_name, 
      author_last_name,
      author_email
    )
  )
  desc$del(
    keys = "Maintainer"
  )
  desc$set_version(
    version = pkg_version
  )
  desc$set(
    Title = pkg_title
  )
  desc$set(
    Description = pkg_description
  )
  if_not_null(
    repo_url, 
    desc$set(
      "URL", 
      repo_url
    )
  )
  if_not_null(
    repo_url, 
    desc$set(
      "BugReports", 
      sprintf(
        "%s/issues", 
        repo_url
      )
    )
  )
  
  desc$write(
    file = "DESCRIPTION"
  )
  
  cat_bullet(
    "DESCRIPTION file modified", 
    bullet = "tick", 
    bullet_col = "green"
  )
}

