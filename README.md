
<!-- README.md is generated from README.Rmd. Please edit that file -->

<link href="inst/reports/default/webex.css" rel="stylesheet" />

# The webex package

<img src="https://raw.githubusercontent.com/PsyTeachR/misc/master/img/webex.001.png" style="float:right; max-width:280px; width: 25%;" />

The goal of webex is to enable instructors to easily create interactive
web pages that students can use in self-guided learning. Although webex
has fewer features than RStudio’s
[learnr](https://rstudio.github.io/learnr/) package, it is more
lightweight: whereas learnr tutorials must be either hosted on a shiny
server or run locally, webex creates standalone HTML files that require
only a JavaScript-enabled browser. It is also extremely simple to use.

## Installation

You can install webex from CRAN using:

``` r
install.packages("webex")
```

You can install the development version of webex from
[GitHub](https://github.com/PsyTeachR/webex) with:

``` r
devtools::install_github("psyteachr/webex")
```

## Creating interactive widgets with inline code

The webex package provides functions that create HTML widgets using
[inline R
code](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown-2.0.pdf).
These functions are:

| function                | widget         | description                    |
| :---------------------- | :------------- | :----------------------------- |
| `fitb()`                | text box       | fill-in-the-blank question     |
| `mcq()`                 | pull-down menu | multiple choice question       |
| `torf()`                | pull-down menu | TRUE or FALSE question         |
| `hide()` and `unhide()` | button         | solution revealed when clicked |
| `total_correct()`       | text           | updating total correct         |

The appearance of the text box and pull-down menu widgets changes when
users enter the correct answer. Answers can be either static or dynamic
(i.e., specified using R code). Widget styles can be changed using
`style_widgets()`.

Examples are provided in the **Web Exercises** R Markdown template. To
create a file from the webex template in RStudio, click `File -> New
File... -> RMarkdown` and in the dialog box that appears, select `From
Template` and choose `Web Exercises`.

Alternatively (or if you’re not using RStudio) use:

``` r
rmarkdown::draft("exercises.Rmd", "webex", "webex")
```

Knit the file to HTML to see how it works. **Note: The widgets only
function in a JavaScript-enabled browser.**

<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This
work is licensed under a
<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative
Commons Attribution-ShareAlike 4.0 International License</a>.
