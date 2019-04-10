
<!-- README.md is generated from README.Rmd. Please edit that file -->
<link href="inst/reports/default/webex.css" rel="stylesheet" />

The webex package
=================

<img src="https://github.com/PsyTeachR/misc/blob/master/img/webex.001.png" style="width:300px" />

The goal of webex is to enable instructors to easily create web documents that students can use in self-guided learning.

Installation
------------

You can install the development version of webex from [GitHub](https://github.com/PsyTeachR/webex) with:

``` r
devtools::install_github("PsyTeachR/webex")
```

The webex package provides a number of functions that you use in [inline R code](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown-2.0.pdf) to create HTML widgets (text boxes, pull down menus, buttons that reveal hidden content). Examples are provided in the **Web Exercises** R Markdown template.

To create a file from the webex template in RStudio, click `File -> New File... -> RMarkdown` and in the dialog box that appears, select `From Template` and choose `Web Exercises`.

Alternatively (or if you're not using RStudio) use:

``` r
rmarkdown::draft("exercises.Rmd", "webex", "webex")
```

Knit the file to HTML to see how it works. **Note: The widgets only function in a JavaScript-enabled browser. The RStudio built-in browser does not have JavaScript. Click the "Open in Browser" button to use your operating system's browser.**

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
