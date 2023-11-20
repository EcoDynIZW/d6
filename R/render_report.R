#' Render an Rmd file placed in ./R to html in ./docs/reports
#'
#' @param rmd A string. Name of the Rmd file
#' 
#' @export
#' @importFrom here here
#' @importFrom rmarkdown render
#' 
#' @examples render_report("doc.rmd")
#' 
render_report <- function(rmd) {
  out <- gsub(".*/", "", rmd)
  
  rmarkdown::render(
    paste0("R/", rmd), 
    output_file = here::here(
      "docs", "reports", 
      paste0(gsub(".Rmd|.rmd|.RMD", "", out), ".html")
    )
  )
}
#' Render All Rmd files placed in ./R to html in ./docs/reports
#'
#' @param sub_dirs Should Rmd files placed in sub directories (./R/.../*.Rmd) be
#'                 rendered? Defaults to FALSE.
#'
#' @export
#' @importFrom here here
#' @importFrom rmarkdown render
#' 
render_all_reports <- function(sub_dirs = FALSE) {
  rmds <- list.files(here::here("R"), pattern = "*.rmd|*.Rmd|*.RMD", recursive = sub_dirs, include.dirs = TRUE)
  out <- gsub(".*/", "", rmds)
  
  purrr::map2(
    rmds,
    out,
    ~rmarkdown::render(
      paste0("R/", .x), 
      output_file = here::here(
        "docs", "reports", 
        paste0(gsub(".Rmd|.rmd|.RMD", "", .y), ".html")
      )
    )
  )
}
