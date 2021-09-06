
<!-- README.md is generated from README.Rmd. Please edit that file -->

<link href="inst/reports/default/webex.css" rel="stylesheet" />

# The `{webexercises}` package

<img src="https://raw.githubusercontent.com/PsyTeachR/misc/master/img/webexercises.001.png" style="float:right; max-width:280px; width: 25%;" />

The goal of `{webexercises}` is to enable instructors to easily create
interactive web pages that students can use in self-guided learning.
Although `{webexercises}` has fewer features than RStudio’s
[learnr](https://rstudio.github.io/learnr/) package, it is more
lightweight: whereas `{learnr}` tutorials must be either hosted on a
shiny server or run locally, `{webexercises}` creates standalone HTML
files that require only a JavaScript-enabled browser. It is also
extremely simple to use.

## Installation

You can install `{webexercises}` from CRAN using:

``` r
install.packages("webexercises")
```

You can install the development version from
[GitHub](https://github.com/PsyTeachR/webexercises) with:

``` r
devtools::install_github("psyteachr/webexercises")
```

## Creating interactive widgets with inline code

The webexercises package provides functions that create HTML widgets
using [inline R
code](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown-2.0.pdf).
These functions are:

| function                | widget         | description                    |
| :---------------------- | :------------- | :----------------------------- |
| `fitb()`                | text box       | fill-in-the-blank question     |
| `mcq()`                 | pull-down menu | multiple choice question       |
| `torf()`                | pull-down menu | TRUE or FALSE question         |
| `longmcq()`             | radio buttons  | MCQs with long answers         |
| `hide()` and `unhide()` | button         | solution revealed when clicked |
| `total_correct()`       | text           | updating total correct         |

The appearance of the text box and pull-down menu widgets changes when
users enter the correct answer. Answers can be either static or dynamic
(i.e., specified using R code). Widget styles can be changed using
`style_widgets()`.

Examples are provided in the **Web Exercises** R Markdown template. To
create a file from the webexercises template in RStudio, click `File ->
New File... -> RMarkdown` and in the dialog box that appears, select
`From Template` and choose `Web Exercises`.

Alternatively (or if you’re not using RStudio) use:

``` r
rmarkdown::draft("exercises.Rmd", "webexercises", "webexercises")
```

Knit the file to HTML to see how it works. **Note: The widgets only
function in a JavaScript-enabled browser.**

## Bookdown

You can add webexercises to a bookdown project or start a new bookdown
project using `add_webex_to_bookdown()`.

``` r
# create a new book
# use default includes and scripts directories (include and R)
add_webexercises_to_bookdown(bookdown_dir = "demo_bs4",
                             output_format = "bs4_book",
                             render = TRUE)

add_webexercises_to_bookdown(bookdown_dir = "demo_git",
                             output_format = "gitbook",
                             render = TRUE)

add_webexercises_to_bookdown(bookdown_dir = "demo_html",
                             output_format = "html_book",
                             render = TRUE)

add_webexercises_to_bookdown(bookdown_dir = "demo_tufte",
                             output_format = "tufte_html_book",
                             render = TRUE)

# update an existing book with custom include and script directories
add_webexercises_to_bookdown(bookdown_dir = ".",
                             include_dir = "www",
                             script_dir = "scripts",
                             output_format = "gitbook")
```

<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This
work is licensed under a
<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative
Commons Attribution-ShareAlike 4.0 International License</a>.
