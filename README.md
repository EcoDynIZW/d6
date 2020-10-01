
# d6 <img src='man/figures/hexlogo_pure.png' align="right" height="151.5" /></a>

### Simplify Workflows of D6 Research Projects

> The goal of the `{d6}` package is to simplify the project workflow
> within the department “Ecologcial Dynamics” at the Leibniz Institute
> for Zoo and Wildlife Research by providing a standardized folder
> structure, templates for reports and utility functions.

There are three main functionalities:

1.  [Create standardized project directories with
    `new_project()`](#create-project-directory)
2.  [Install a set of common packages with
    `install_d6_packages()`](#install-common-packages)
3.  [Provide custom Rmarkdown templates via `File > New File >
    Rmarkdown... > From Template`](#use-custom-rmarkdown-templates)
4.  [Render all Rmarkdown documents to ./docs/report with
    `render_all_reports()`](#render-rmarkdown-files-to-reports)

# 

## Installation

The package is not on CRAN and needs to be installed from GitHub. To do
so, open Rstudio and run the following two lines in the console. In case
the `{devtools}` package is already installed, skip that step.

``` r
install.packages("devtools")
devtools::install_github("EcoDynIZW/d6")
```

# 

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

# 

## Install Common Packages

You can install the packages that are most commonly used in our
department via `install_d6_packages()`:

``` r
d6::install_d6_packages()
```

Note that this function is going to check preinstalled versions and will
only install packages that are not installed with your current R
version.

Again, there is an arguement `geo` so you can decide if you want to
install common geodata packages as well (which is the default). If you
are not intending to process geodata, set `geo` to `FALSE`:

``` r
d6::install_d6_packages(geo = FALSE)
```

# 

## Use Custom Rmarkdown Templates

The package also provides several templates for your scripts. In
Rstudio, navigate to `File > New File > RMarkdown... > Templates` and
choose the template you want to use. All templates come with a
preformatted YAML header and chunks for the setup.

The following templates are available for now:

  - *EcoDynIZW Basic*: Template for a basic Rmarkdown research report
    (mostly empty)
  - *EcoDynIZW Data*: Template for an Rmarkdown research report for data
    import and cleaning

# 

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
d6::render_report("my-report.Rmd")
d6::render_report("notsurewhybutIhaveasubfolder/my-report.Rmd")
```

<br>

-----

<br>

### Acknowledgements:

This package would not exist without the work of many great people\!

  - The code to create the project folder is based on the [template
    package by Francisco
    Rodriguez-Sanchez](https://github.com/Pakillo/template) (and
    references therein)
  - The 00\_start script is inspired by the [`{golem}`
    package](https://thinkr-open.github.io/golem/)
  - Rstudio for the development of Rmarkdown and all the great things
    that come with it (knitting, templates, themes, …)

# 

#### Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

<div style="width:300px; height:200px">

<img src=https://camo.githubusercontent.com/00f7814990f36f84c5ea74cba887385d8a2f36be/68747470733a2f2f646f63732e636c6f7564706f7373652e636f6d2f696d616765732f63632d62792d6e632d73612e706e67 alt="" height="42">

</div>
