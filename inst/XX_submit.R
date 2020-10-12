## Render your scripts to html
## Render all .Rmd files placed in ./R
d6::render_all_reports()
## Or render each step by step
## Add additonal lines for each .Rmd file placed in ./R that you want to render
d6::render_report("myRMD.Rmd")
 
## Build Dockerfile
#devtools::install_github("karthik/holepunch")
holepunch::write_dockerfile()