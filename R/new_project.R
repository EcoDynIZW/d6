#' Create new project scaffolding.
#'
#' Create all the scaffolding for a new project in a new directory. The scaffolding includes a \code{DESCRIPTION} and \code{NAMESPACE} file, \code{.gitignore}, different folders to hold raw data, outputs, documents, figures, and scripts, as well as \code{RProject} infrastructure. Also, optionally, set a GitHub repo and exclude geo data directories.
#'
#' @param name Name of the new project. A new folder will be created with that name.
#' @param path Path of the new project where the folder is created. If empty then the current working directory is used.
#' @param github Logical. Create GitHub repo? Note this requires a \code{GITHUB_PAT}. See instructions \href{URL}{https://gist.github.com/Z3tt/3dab3535007acf108391649766409421}{here}.
#' @param private_repo Logical. Should the repo be private or public? Default is \code{TRUE} which equals to private.
#'
#' @return A new directory with a project structure based on the common package structure, slightly modified. Also includes scripts for start and end of each project.
#' @export
#' @import fs devtools usethis
#' @importFrom cli cat_bullet 
#' @importFrom utils menu
#'
new_project <- function(name, path = getwd(), github = FALSE, private_repo = TRUE){
  
  ## check path string
  end <- substr(path, (nchar(path) + 1) - 1, nchar(path))
  if(end == "/") { path_full <- paste0(path, name) } else { path_full <- paste0(path, "/", name) }
  
  ## check if folder exists already
  if (fs::dir_exists(path_full)){
    res <- yesno(
      paste("The path", path_full, "already exists, overwrite?")
    )
    if (!res){
      return(invisible(NULL))
    }
  }
  
  ## create main dir + relevant files
  #devtools::create(path_full, check_name = FALSE)
  usethis::create_project(path_full)
  
  ## remove R folder that is created by devtools::create()
  unlink(file.path(path_full, "R"), recursive = TRUE) 
  
  usethis::proj_set(path_full)
  
  cat_green_tick("Created project directory")
  
  ## create directories
  
  #> docs dirs
  dir.create(file.path(path_full, "docs", "admin"), recursive = TRUE)
  dir.create(file.path(path_full, "docs", "literature"))
  dir.create(file.path(path_full, "docs", "manuscript"))
  dir.create(file.path(path_full, "docs", "presentations"))
  dir.create(file.path(path_full, "docs", "reports"))
  
  #> data dirs
  dir.create(file.path(path_full, "data", "raw", "geo"), recursive = TRUE)
  dir.create(file.path(path_full, "data", "processed", "geo"), recursive = TRUE)
  
  #> results dirs
  dir.create(file.path(path_full, "results"))
  
  #> plots dir
  dir.create(file.path(path_full, "plots"))
  
  #> scripts dir
  dir.create(file.path(path_full, "scripts"))
  
  cat_green_tick("Created directories")
  
  ## add scripts
  file.copy(
    system.file("00_start.R", package = "d6"),
    file.path(path_full, "scripts")
  )
  file.copy(
    system.file("zz_submit.R", package = "d6"),
    file.path(path_full, "scripts")
  )
  
  cat_green_tick("Added helper scripts")
  
  ## add README
  usethis::use_readme_md(open = TRUE)
  
  ## add GitHub
  if (github){
    usethis::use_git()
    usethis::use_github(private = private_repo)
  }

  cat_green_tick("DONE")
  
  cli::cat_line(
    paste0(
      "\nA new project named ", 
      name, 
      " was created at ", 
      fs::path_abs(path),
      ".\n\n", 
      "To continue working on your project, start editing the README.md file in the new Rstudio session.",
    )
  )
  
}

