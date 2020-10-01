
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

There are three main functionalities:

1.  Create project directiories with `new_project()`
2.  Install a set of common packages with `install_d6_packages()`
3.  Provide custom Rmarkdown templates via `File > New File >
    Rmarkdown... > From Template`
4.  Render all Rmarkdown documents to the ./docs/report directory with
    `render_all_reports()`

## Create Project Directory

Run the function `new_project` to create a new project. This will create
a directory with all the scaffolding we use for all projects in our
department. It also add several files needed for documentation of your
project.

To start a new project in the current working directory, simply run:

``` r
d6::new_project("project")
```

#### Use A Custom Root Directory

You don’t need to change the working directory first—you can also
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

#### Add Documentation to Your Project

After you have set up your project directory, open the file `00_start.R`
in the `R` folder. Add the details of your project, fill in the readme,
add a MIT license (if needed) and add package dependencies.

## Install Common Packages

You can install the packages that are most commonly used in our
department via `install_d6_packages()`:

``` r
d6::install_d6_packages()
```

Again, there is an arguement `geo` so you can decide if you want to
install common geodata packages as well (which is the default). If you
are not intending to process geodata, set `geo` to `FALSE`:

``` r
d6::install_d6_packages(geo = FALSE)
```

## Use Custom Rmarkdown Templates

The package also provides several templates for your scripts. In
Rstudio, navigate to `File > New File > RMarkdown... > Templates` and
choose the template you want to use. All templates come with a
preformatted YAML header and chunks for the setup.

<<<<<<< Updated upstream
The following templates are available:


Based on the [template package by Francisco Rodriguez-Sanchez](https://github.com/Pakillo/template)
=======
The following templates are available for now:

  - *EcoDynIZW Basic*: Template for a basic Rmarkdown research report
    (mostly empty)
  - *EcoDynIZW Data*: Template for a Rmarkdown research report for data
    import and cleaning

## Render Rmarkdown Files to Reports

The `render_*()` functions take care of knitting your Rmarkdown files
into HTML reports. The functions assume that your .Rmd files are saved
in the `R` directory or any subdirectory, and will store the resulting
.html files in the according directory, namely `./docs/reports/`.

You can render all .Rmd files that are placed in the `R` directory and
subdirectories in one step:

``` r
d6::render_all_reports()
```

You can also render single Rmarkdown documents via `render_report()`:

``` r
d6::render_all_reports()
```
>>>>>>> Stashed changes
