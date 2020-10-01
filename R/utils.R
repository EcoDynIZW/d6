#' @importFrom cli cat_bullet
#' @importFrom utils menu
cat_green_tick <- function(...){
  cat_bullet(
    ..., 
    bullet = "tick", 
    bullet_col = "green"
  )
}

cat_red_bullet <- function(...){
  cat_bullet(
    ..., 
    bullet = "bullet",
    bullet_col = "red"
  )
}

yesno <- function (...) 
{
  cat(paste0(..., collapse = ""))
  menu(c("Yes", "No")) == 1
}