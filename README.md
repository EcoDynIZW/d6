
## `d6` package

### Generic template for D6 research projects

This package works as a template for new research projects, under the
idea of having everything (data, R scripts, functions and
manuscript/reports) contained in the same package (a ‘research
compendium’) to facilitate collaboration and promote reproducibility.

### Installation

``` r
devtools::install_github("EcoDynIZW/template")
```

### Usage

1.  First, load the package

<!-- end list -->

``` r
library("template")
```

2.  Now run the function `new_project` to create a directory with all
    the scaffolding (slightly modified from R package structure). For
    example, to start a new project about tree growth, just use:

<!-- end list -->

``` r
new_project("project")
```

If you want to create a private GitHub repository for the project at the
same time, use instead:

``` r
new_project("project", github = TRUE, private.repo = TRUE)
```

Note that to create a GitHub repo you will need to have configured your
system as explained in
<http://www.rdocumentation.org/packages/devtools/functions/use_github>.
And for Travis to run you will need to activate it at
<https://travis-ci.org/profile>.
