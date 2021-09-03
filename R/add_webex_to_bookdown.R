#' Add webex to bookdown
#'
#' @param bookdown_dir The base directory for your bookdown project
#' @param include_dir The directory where you want to put the css and js files (defaults to "include")
#' @param script_dir The directory where you want to put the .R script (defaults to "R")
#' @param output_format The bookdown format you want to add webex to (defaults to "bookdown::bs4_book") This is typically your default HTML format in the _output.yml file
#'
#' @return NULL
#' @export
#'
add_webex_to_bookdown <- function(bookdown_dir = ".", 
                                  include_dir = "include", 
                                  script_dir = "R",
                                  output_format = "bookdown::bs4_book") {
  if (bookdown_dir == "") bookdown_dir <- "."
  if (include_dir == "") include_dir <- "."
  if (script_dir == "") script_dir <- "."
  
  css <- system.file("reports/default/webex.css", package = "webex")
  js <- system.file("reports/default/webex.js", package = "webex")
  script <- system.file("reports/default/webex.R", package = "webex")
  
  incdir <- file.path(bookdown_dir, include_dir)
  dir.create(path = incdir, showWarnings = FALSE, recursive = TRUE)
  
  file.copy(css, incdir)
  file.copy(js, incdir)
  file.copy(script, incdir)
  
  # update or create _output.yml
  output_file <- file.path(bookdown_dir, "_output.yml")
  if (!file.exists(output_file)) {
    # keep default yml
    yml <- list()
    yml[[output_format]] <- list()
  } else {
    yml <- yaml::read_yaml(output_file)
    if (!output_format %in% names(yml)) {
      # append output_format
      yml[[output_format]] <- list()
    }
  }
  
  old_css <- yml[[output_format]]$css
  old_js <- yml[[output_format]]$includes$after_body
  old_md <- yml[[output_format]]$md_extensions
  
  yml[[output_format]]$css <- union(old_css, file.path(include_dir, "webex.css"))
  yml[[output_format]]$includes$after_body <- union(old_js, file.path(include_dir, "webex.js"))
  yml[[output_format]]$md_extensions <- union(old_md, "-smart")
  
  yaml::write_yaml(yml, output_file)
  message(output_file, " updated")
  
  # update or create _bookdown.yml
  bookdown_file <- file.path(bookdown_dir, "_bookdown.yml")
  if (file.exists(bookdown_file)) {
    yml <- yaml::read_yaml(bookdown_file)
  } else {
    yml <- list()
  }
  
  old_bcs <- yml$before_chapter_script
  yml$before_chapter_script <- union(old_bcs, file.path(script_dir, "webex.R"))
  yaml::write_yaml(yml, bookdown_file)
  message(output_file, " updated")
}
