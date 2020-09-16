#' Create new project scaffolding.
#'
#' Create all the scaffolding for a new project in a new directory. The scaffolding includes a \code{README.Rmd} file, different folders to hold raw data, analyses, etc, and \code{testthat} infrastructure. Also, optionally, set a GitHub repo and add Travis-CI.
#'
#' @param name Name of the new project. A new folder will be created with that name.
#' @param path path of the new project where the folder is created. If empty then the current working directory is used.
#' @param github Logical. Create GitHub repo? Note this requires a \code{GITHUB_PAT}. See \code{\link[devtools]{use_github}}.
#' @param private_repo Logical. Default is TRUE.
#' @param geo Logical. Create directories for spatial data? Default is TRUE.
#'
#' @return A new directory with R package structure, slightly modified.
#' @export
#' @import fs devtools usethis golem
#'
new_project <- function(name, path = getwd(), github = FALSE, private_repo = TRUE, geo = TRUE){

  end <- substr(path, (nchar(path) + 1) - 1, nchar(path))
  
  if(end == "/") { path_full <- paste0(path, name) } else { path_full <- paste0(path, "/", name) }
  
  if (fs::dir_exists(path_full)){
    res <- golem:::yesno(
      paste("The path", path_full, "already exists, override?")
    )
    if (!res){
      return(invisible(NULL))
    }
  }
  
  devtools::create(path_full)
  
  golem:::cat_green_tick("Created project directory")
  
  ## docs dir
  dir.create(file.path(path_full, "docs"))
  dir.create(file.path(path_full, "docs", "admin"))
  dir.create(file.path(path_full, "docs", "literature"))
  dir.create(file.path(path_full, "docs", "manuscript"))
  dir.create(file.path(path_full, "docs", "presentations"))
  ## data dir
  dir.create(file.path(path_full, "data-raw"))
  #dir.create(file.path(path_full, "data", "data_raw"))
  #dir.create(file.path(path_full, "data", "geo_raw"))
  if(geo == TRUE) { dir.create(file.path(path_full, "data-raw", "geo-raw")) }
  ## output dir
  dir.create(file.path(path_full, "output"))
  dir.create(file.path(path_full, "output", "data-proc"))
  if(geo == TRUE) { dir.create(file.path(path_full, "output", "geo-proc")) }
  dir.create(file.path(path_full, "output", "plots"))
  dir.create(file.path(path_full, "output", "tables"))
  
  golem:::cat_green_tick("Created directories")
  
  #cat("\n^analyses$ \n^manuscript$ \n", sep = "",
  #    file = file.path(name, ".Rbuildignore"), append = TRUE)

  setwd(path_full)
  try(usethis::use_readme_md(), silent = TRUE)
  try(usethis::use_package_doc(), silent = TRUE)
  #usethis::use_data_raw(path_full)
  #usethis::use_testthat(path_full)
  
  golem:::cat_green_tick("Added project descriptions")
  
  file.copy(
    system.file("01_start.R", package = "d6proj"),
    path_full
  )
  
  if (github){
    usethis::use_github(pkg = name, private = private_repo)
    usethis::use_github_links(name)
  }

  golem:::cat_green_tick("DONE")
  
  cli::cat_line(
    paste0(
      "\nA new project named ", 
      name, 
      " was created at ", 
      fs::path_abs(path),
      " .\n\n", 
      "To continue working on your project, start editing the 01_start.R file in the new Rstudio session."
    )
  )
  
}

