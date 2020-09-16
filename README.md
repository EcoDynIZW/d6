
# `d6` package <img src='man/figures/hexlogo_workflow_2.png' align="right" height="151.5" /></a>

## Generic templates for D6 research projects

This package works as a template for new research projects, under the
idea of having everything (data, R scripts, functions and
manuscript/reports) contained in the same package (a ‘research
compendium’) to facilitate collaboration and promote reproducibility.

### Installation

``` r
devtools::install_github("EcoDynIZW/d6")
```

### Usage

To create a new project, run the function `new_project`. This will
create a directory with all the scaffolding we use for all projects in
our department. For example, to start a new project in the current
working directory, just use:

``` r
d6::new_project("project")
```

You don’t need to change the working directory firstyou can also specify
a path:

``` r
## both work:
d6::new_project("project", path = "absolute/path/to/the/root/folder")
## or:
d6::new_project("project", path = "absolute/path/to/the/root/folder/")
```

If you want to create a GitHub repository for the project at the same
time, use instead:

``` r
d6::new_project("project", github = TRUE)
```

By default, the visibility of the GitHub repository is set to “private”
but you can also change that:

``` r
d6::new_project("project", github = TRUE, private_repo = F)
```

Note that to create a GitHub repo you will need to have configured your
system as explained
[here](http://www.rdocumentation.org/packages/devtools/functions/use_github).
