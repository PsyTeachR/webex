test_that("empty bookdown directory", {
  skip_on_cran() # not all CRAN installations have pandoc
  
  bookdown_dir <- tempfile()
  dir.create(bookdown_dir, FALSE)
  include_dir <- "include"
  script_dir <- "R"
  output_format <- "bookdown::bs4_book"
  
  oyml <- file.path(bookdown_dir, "_output.yml")
  byml <- file.path(bookdown_dir, "_bookdown.yml")
  
  expect_message(add_webexercises_to_bookdown(bookdown_dir), "updated")
  
  expect_true(file.exists(oyml))
  expect_silent(check_oyaml <- yaml::read_yaml(oyml))
  
  expect_equal(names(check_oyaml), output_format)
  
  expect_equal(check_oyaml[[output_format]]$css, "include/webex.css")
  expect_equal(check_oyaml[[output_format]]$includes$after_body, "include/webex.js")
  expect_equal(check_oyaml[[output_format]]$md_extensions, "-smart")
  
  expect_true(file.exists(byml))
  expect_silent(check_byaml <- yaml::read_yaml(byml))
  expect_true("before_chapter_script" %in% names(check_byaml))
  expect_equal(check_byaml$before_chapter_script, "R/webex.R")
  
  css <- file.path(bookdown_dir, include_dir, "webex.css")
  js <- file.path(bookdown_dir, include_dir, "webex.js")
  r <- file.path(bookdown_dir, script_dir, "webex.R")
  expect_true(file.exists(css))
  expect_true(file.exists(js))
  expect_true(file.exists(r))
})

test_that("empty bookdown_dir, include_dir", {
  skip_on_cran() # not all CRAN installations have pandoc
  
  tdir <- tempfile()
  dir.create(tdir, FALSE)
  oldwd <- getwd()
  on.exit(setwd(oldwd))
  setwd(tdir)
  
  bookdown_dir <- ""
  include_dir <- ""
  script_dir <- ""
  output_format <- "bookdown::bs4_book"
  yml <- file.path(".", "_output.yml")
  byml <- file.path(".", "_bookdown.yml")
  
  expect_message(add_webexercises_to_bookdown(bookdown_dir, include_dir, script_dir), "updated")
  
  expect_true(file.exists(yml))
  expect_silent(check_yaml <- yaml::read_yaml(yml))
  
  expect_equal(names(check_yaml), output_format)
  
  expect_equal(check_yaml[[output_format]]$css, "./webex.css")
  expect_equal(check_yaml[[output_format]]$includes$after_body, "./webex.js")
  expect_equal(check_yaml[[output_format]]$md_extensions, "-smart")
  
  expect_true(file.exists(byml))
  expect_silent(check_byaml <- yaml::read_yaml(byml))
  expect_true("before_chapter_script" %in% names(check_byaml))
  expect_equal(check_byaml$before_chapter_script, "./webex.R")
  
  # new output
  output_format2 <- "bookdown::html_book"
  expect_message(add_webexercises_to_bookdown(bookdown_dir, include_dir, script_dir, "html_book"), "updated")
  expect_true(file.exists(yml))
  expect_silent(check_yaml <- yaml::read_yaml(yml))
  
  expect_equal(names(check_yaml), c(output_format, output_format2))
  expect_equal(check_yaml[[output_format2]]$css, "./webex.css")
  expect_equal(check_yaml[[output_format2]]$includes$after_body, "./webex.js")
  expect_equal(check_yaml[[output_format2]]$md_extensions, "-smart")
  
  expect_true(file.exists(byml))
  expect_silent(check_byaml <- yaml::read_yaml(byml))
  expect_true("before_chapter_script" %in% names(check_byaml))
  expect_equal(check_byaml$before_chapter_script, "./webex.R")
})

test_that("preexisting _output.yml", {
  skip_on_cran() # not all CRAN installations have pandoc
  
  tdir <- tempfile()
  dir.create(tdir, FALSE)
  oldwd <- getwd()
  on.exit(setwd(oldwd))
  setwd(tdir)
  
  bookdown_dir <- "."
  include_dir <- "."
  output_format <- "bookdown::bs4_book"
  yml <- file.path(".", "_output.yml")
  byml <- file.path(".", "_bookdown.yml")
  
  write("bookdown::bs4_book:
  default: true
  df_print: kable
  repo:
    base: https://github.com/psyteachr/template
    branch: master
    subdir: book
  includes:
    in_header: include/header.html
    after_body: include/script.js
  css: [include/psyteachr.css, include/style.css]
  theme:
    primary: \"#467AAC\"
", yml)
  
  write("book_filename: \"_main\"
new_session: yes
output_dir: \"../docs\"
before_chapter_script: \"R/psyteachr_setup.R\"
delete_merged_file: true
clean: []
", byml)
  
  expect_message(add_webexercises_to_bookdown(), "updated")
  
  expect_true(file.exists(yml))
  expect_silent(check_yaml <- yaml::read_yaml(yml))
  
  expect_equal(names(check_yaml), output_format)
  expect_equal(names(check_yaml[[output_format]]), c("default", "df_print", "repo", "includes", "css", "theme", "md_extensions"))
  
  expect_equal(check_yaml[[output_format]]$css, c("include/psyteachr.css", "include/style.css", "include/webex.css"))
  expect_equal(check_yaml[[output_format]]$includes$after_body, c("include/script.js", "include/webex.js"))
  expect_equal(check_yaml[[output_format]]$md_extensions, "-smart")
  
  expect_true(file.exists(byml))
  expect_silent(check_byaml <- yaml::read_yaml(byml))
  expect_true("before_chapter_script" %in% names(check_byaml))
  expect_equal(check_byaml$before_chapter_script, c("R/psyteachr_setup.R", "R/webex.R"))
})

test_that("new books", {
  skip_on_cran() # not all CRAN installations have pandoc
  
  tdir <- tempfile()
  dir.create(tdir, FALSE)
  oldwd <- getwd()
  on.exit(setwd(oldwd))
  setwd(tdir)
  
  render = interactive()
  
  # needs visual inspection to check sites
  add_webexercises_to_bookdown(bookdown_dir = "demo_bs4",
                               output_format = "bs4_book",
                               render = render)
  
  add_webexercises_to_bookdown(bookdown_dir = "demo_git",
                               output_format = "gitbook",
                               render = render)
  
  add_webexercises_to_bookdown(bookdown_dir = "demo_html",
                               output_format = "html_book",
                               render = render)
  
  add_webexercises_to_bookdown(bookdown_dir = "demo_tufte",
                               output_format = "tufte_html_book",
                               render = render)
  
})
