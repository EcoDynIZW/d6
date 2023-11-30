
# d6 <img src='man/figures/hexlogo_pure.png' align="right" height="151.5" /></a>

### Simplify Workflows of D6 Research Projects

> The goal of the `{d6}` package is to simplify the project workflow
> within the department “Ecological Dynamics” at the Leibniz Institute
> for Zoo and Wildlife Research by providing a standardized folder
> structure, templates for reports, and utility functions.

There are five main functionalities:

1.  [Create standardized project directories with `new_project()`](#create-project-directory)
2.  [Install a set of common packages with `install_d6_packages()`](#install-common-packages)
3.  [Create figures that match our lab identity via `theme_d6()`](#corporate-ggplot2-theme)
4.  [Provide custom Rmarkdown templates via `File > New File > Rmarkdown... > From Template`](#use-custom-rmarkdown-templates)
5.  [Render all your Rmarkdown documents to ./docs/report with `render_all_reports()` or `render_report()`](#render-rmarkdown-files-to-reports)

<br>The function [`simple_load()` is a utility function](#simple-load-packages) that is currently in an experimental state. It allows you to install (if not yet) and load a set of packages—even a combination of CRAN and GitHub packages—in a single step.

<br>

------------------------------------------------------------------------

<br>

## Installation

The package is not on CRAN and needs to be installed from GitHub. To do
so, open Rstudio and run the following two lines in the console. In case
the `{devtools}` package is already installed, skip that step.

``` r
install.packages("devtools")
devtools::install_github("EcoDynIZW/d6")
```

(Note: If you are asked if you want to update other packgaes either
press “No” (option 3) and continue or update the packages before running
the install command again.)

<br>

------------------------------------------------------------------------

<br>

## Create Project Directory {#create-project-directory}

Run the function `new_project()` to create a new project. This will
create a standardized directory with all the scaffolding we use for all
projects in our department. It also add several files needed for
documentation of your project.

To start a new project in the current working directory, simply run:

``` r
d6::new_project("unicornus_wl_sdm_smith_j")
```

*Please give your project a unique and descriptive name:
**species\_country\_topic\_name***

For example, when John Smith is developing a species distribution models
for unicorns in Wonderland, a descriptive title could be:
`unicornus_wl_sdm_smith_j`. Please use underscores and the
[international Alpha-2 encoding for
countries](https://www.iban.com/country-codes).

The main folders created in the root folder (here
`unicornus_wl_sdm_smith_j`) are the following:

``` text
.
└── unicornus_wl_sdm_smith_j
    ├── data-raw
    ├── docs
    ├── output
    ├── plots
    └── R
```

The full scaffolding structure including all subdirectories and
additional files looks like this:

``` text
. 
└── unicornus_wl_sdm_smith_j
    ├── .Rproj.user         —  Rproject files
    ├── data-raw            —  raw data (tabular data in root folder)
    │   └── geo-raw         —  raw spatial data
    ├── docs                —  documents
    │   ├── admin           —  adminstrative docs, e.g. permits 
    │   ├── literature      —  literature used for parameterization + ms
    │   ├── manuscript      —  manuscript drafts (main + supplement)
    │   ├── presentations   —  talks and poster presentations
    │   └── reports         —  rendered reports
    ├── output              —  everything that is computed (except plots)
    │   ├── data-proc       —  processed tabular data
    │   └── geo-proc        —  processed spatial data
    ├── plots               —  plot output
    ├── R                   —  scripts
    │   ├── 00_start.R      —  first script to run
    │   └── XX_submit.R     —  final script to run
    ├── .gitignore          —  contains which files to ignore for version control
    ├── .Rbuildignore       —  contains which files to ignore for package builds
    ├── DESCRIPTION         —  contains project details and package dependencies
    ├── NAMESPACE           —  contains context for R objects
    └── project.Rproj       —  Rproject file: use to start your project
```

# 

#### Use A Custom Root Directory

You don’t need to change the working directory first—you can also
specify a path to a custom root folder in which the new project folder
is created:

``` r
## both work:
d6::new_project("unicornus_wl_sdm_smith_j", path = "absolute/path/to/the/root/folder")
## or:
d6::new_project("unicornus_wl_sdm_smith_j", path = "absolute/path/to/the/root/folder/")
```

The resulting final directory of your project would be
`absolute/path/to/the/root/folder/unicornus_wl_sdm_smith_j`.

# 

#### Use Version Control

If you want to create a GitHub repository for the project at the same
time, use instead:

``` r
d6::new_project("unicornus_wl_sdm_smith_j", github = TRUE)
```

By default, the visibility of the GitHub repository is set to “private”
but you can also change that:

``` r
d6::new_project("unicornus_wl_sdm_smith_j", github = TRUE, private_repo = FALSE)
```

Note that to create a GitHub repo you will need to have configured your
system as explained
[here](https://gist.github.com/Z3tt/3dab3535007acf108391649766409421).

# 

#### Setup without Geo Directories

If your project does not (or will not) contain any spatial data, you can
prevent the creation of the directories `geo-raw` and `geo-proc` by
setting `geo` to `FALSE`:

``` r
d6::new_project("unicornus_wl_sdm_smith_j", geo = FALSE)
```

# 

#### Add Documentation to Your Project

After you have set up your project directory, open the file `00_start.R`
in the `R` folder. Add the details of your project, fill in the readme,
add a MIT license (if needed) and add package dependencies.

<br>

------------------------------------------------------------------------

<br>

## Install Common Packages {#install-common-packages}

You can install the packages that are most commonly used in our
department via `install_d6_packages()`:

``` r
d6::install_d6_packages()
```

Note that this function is going to check preinstalled versions and will
only install packages that are not installed with your current R
version.

Again, there is an argument `geo` so you can decide if you want to
install common geodata packages as well (which is the default). If you
are not intending to process geodata, set `geo` to `FALSE`:

``` r
d6::install_d6_packages(geo = FALSE)
```

The default packages that are going to be installed are:

``` text
tidyverse (tibble, dplyr, tidyr, ggplot2, readr, forcats, stringr, purrr), lubridate, here, vroom, patchwork, remotes
```

The following packages will be installed in case you specify
`geo = TRUE`:

``` text
sf, terra, stars, tmap
```

<br>

------------------------------------------------------------------------

<br>

## Corporate ggplot2 Theme {#corporate-ggplot2-theme}

The package provides a ggplot2 theme with sensible defaults and additional 
utilities to simplify the process of creating a good-looking, clean look.
Furthermore, we aim to have a consistent look across all our figures shown
in manuscripts, presentations, and posters.

The theme can be added to a ggplot object as usual:

```r
library(ggplot2)
ggplot(mpg, aes(x = displ, y = cty)) +
  geom_point() +
  d6::theme_d6()
```

Or set as the new global theme by overwriting the current default:

```r
theme_set(d6::theme_d6())
```

### Typefaces

The D6 corporate theme uses the PT font superfamily and will inform you to
install the relevant files in case they are missing on your machine:

- [PT Sans](https://fonts.google.com/specimen/PT+Sans)
- [PT Serif](https://fonts.google.com/specimen/PT+Serif)
- [PT Mono](https://fonts.google.com/specimen/PT+Mono)

By default, the theme uses PT Sans. If you prefer serif fonts or such a
typeface is required, you can set `serif = TRUE` inside the theme:

```r
ggplot(mpg, aes(x = displ, y = cty)) +
  geom_point() +
  d6::theme_d6(serif = TRUE)
```


### Additional Utility Arguments

In addition to the common arguments to specify the bas settings
(`base_family`, `base_size`, `base_line_size`, and `base_rect_size`), 
we have added the following utility settings to simplify the modification
of the theme:

-  `grid`: remove or add major grid lines (`"xy"` by default)
-  `legend`: control legend position (`"bottom"` by default)
-  `mono`: use a tabular, monospaced font for numeric scales such as x, y, and legends (`"none"` by default)
-  `bg`: define background color (`"transparent"` by default)
-  `serif`: set main typeface (`FALSE` by default; see above)

```r
ggplot(mpg, aes(x = class, y = hwy, color = factor(year))) + 
  geom_boxplot() +
  d6::theme_d6(
    grid = "y",
    legend = "top",
    mono = "yl",
    bg = "cornsilk"
  )
```

<br>

------------------------------------------------------------------------

<br>

## Use Custom Rmarkdown Templates({#use-custom-rmarkdown-templates}

The package also provides several templates for your scripts. In
Rstudio, navigate to `File > New File > RMarkdown... > Templates` and
choose the template you want to use. All templates come with a
preformatted YAML header and chunks for the setup.

The following templates are available for now:

-   *EcoDynIZW Basic*: Template for a basic Rmarkdown research report
    including bits of codes and comments to get started
-   *EcoDynIZW Minimal*: Template for an Rmarkdown research report
    (almost empty)

<br>

------------------------------------------------------------------------

<br>

## Render Rmarkdown Files to Reports {#render-rmarkdown-files-to-reports}

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

------------------------------------------------------------------------

<br>

## Install and Load a Set of Packages {#simple-load-packages}

The `simple_load()` function takes a vector of packages, checks if they 
are installed already, installs them if needed, and loads them via 
`library()` afterward. You can provide both, CRAN and GitHub packages, 
at the same time. GitHub packages need to be specified as 
"owner/repository" without any spaces.

``` r
d6::simple_load(pcks = c("dplyr", "ggplot2", "EcoDynIZ/d6berlin"))
```

You can also force a reinstallation of packages. CRAN and GitHub packages 
are controlled individually via `update_cran` and `update_gh`, respectively.

``` r
d6::simple_load(pcks = c("dplyr", "ggplot2", "EcoDynIZ/d6berlin"),
                update_cran = TRUE, update_gh = TRUE)
```

<br>

------------------------------------------------------------------------

<br>

### Acknowledgements:

This package would not exist without the work of many great people!

-   The code to create the project folder is based on the [template
    package by Francisco
    Rodriguez-Sanchez](https://github.com/Pakillo/template) (and
    references therein)
-   The 00\_start script is inspired by the [`{golem}`
    package](https://thinkr-open.github.io/golem/)
-   Rstudio for the development of Rmarkdown and all the great things
    that come with it (knitting, templates, themes, …)

#### Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

<div style="width:300px; height:200px">

<img src=https://camo.githubusercontent.com/00f7814990f36f84c5ea74cba887385d8a2f36be/68747470733a2f2f646f63732e636c6f7564706f7373652e636f6d2f696d616765732f63632d62792d6e632d73612e706e67 alt="" height="42">

</div>
