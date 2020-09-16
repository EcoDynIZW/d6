
# `d6` Package <img src='man/figures/hexlogo_pure.png' align="right" height="151.5" /></a>

### Generic Templates for D6 Research Projects

This package works as a template for new research projects, under the
idea of having everything (data, R scripts, functions and
manuscript/reports) contained in the same package (a ‘research
compendium’) to facilitate collaboration and promote reproducibility.

## Installation

The package is not on CRAN and needs to be installed from GitHub. To do
so, open Rstudio and run the following two lines in the console. In case
the `{devtools}` package is already installed, skip that step.

``` r
install.packages("devtools")
devtools::install_github("EcoDynIZW/d6")
```

## Create Project Directory

To create a new project, run the function `new_project`. This will
create a directory with all the scaffolding we use for all projects in
our department. For example, to start a new project in the current
working directory, simply run:

``` r
d6::new_project("project")
```

#### Use A Custom Root Directory

You don’t need to change the working directory first you can also
specify a path to a custom root folder in which the new project folder
is created:

``` r
## both work:
d6::new_project("project", path = "absolute/path/to/the/root/folder")
## or:
d6::new_project("project", path = "absolute/path/to/the/root/folder/")
```

The resulting final directory of your project would be
`absolute/path/to/the/root/folder/project`.

#### Use Version Control

If you want to create a GitHub repository for the project at the same
time, use instead:

``` r
d6::new_project("project", github = TRUE)
```

By default, the visibility of the GitHub repository is set to “private”
but you can also change that:

``` r
d6::new_project("project", github = TRUE, private_repo = FALSE)
```

Note that to create a GitHub repo you will need to have configured your
system as explained
[here](http://www.rdocumentation.org/packages/devtools/functions/use_github).

#### Setup without Geo Directories

If your project does not (or will not) contain any spatial data, you can
prevent the creation of the directories `geo-raw` and `geo-proc` by
setting `geo` to `FALSE`:

``` r
d6::new_project("project", geo = FALSE)
```

## Add Documentation to Your Project

After you have set up your project directory, open the file `00_start.R`
in the `R` folder. Add the details of your project, fill in the readme,
add a MIT license (if needed) and add package dependencies.

## Use Script Templates

The package also provides several templates for your scripts. In
Rstudio, navigate to `File > New File > RMarkdown... > Templates` and
choose the template you want to use.

The following templates are available:
