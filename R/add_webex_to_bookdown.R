#' Add webex to bookdown
#' 
#' Adds the necessary helper files to an existing bookdown project and edits the _output.yml and _bookdown.yml files accordingly. If the directory does not have a bookdown project in it, a template project will be set up.
#'
#' @param bookdown_dir The base directory for your bookdown project
#' @param include_dir The directory where you want to put the css and js files (defaults to "include")
#' @param script_dir The directory where you want to put the .R script (defaults to "R")
#' @param output_format The bookdown format you want to add webex to (defaults to "bs4_book") This is typically your default HTML format in the _output.yml file
#' @param render Whether to render the book after updating (defaults to FALSE)
#'
#' @return NULL
#' @export
#'
add_webex_to_bookdown <- function(bookdown_dir = ".", 
                                  include_dir = "include", 
                                  script_dir = "R",
                                  output_format = c("bs4_book", "gitbook", "html_book", "tufte_html_book"),
                                  
                                  render = FALSE) {
  # check inputs
  if (bookdown_dir == "") bookdown_dir <- "."
  if (include_dir == "") include_dir <- "."
  if (script_dir == "") script_dir <- "."
  output_format <- paste0("bookdown::", match.arg(output_format))
  
  # get helper files
  css <- system.file("reports/default/webex.css", package = "webex")
  js <- system.file("reports/default/webex.js", package = "webex")
  script <- system.file("reports/default/webex.R", package = "webex")
  index <- system.file("reports/default/index.Rmd", package = "webex")
  
  # make sure include and script directories exist
  incdir <- file.path(bookdown_dir, include_dir)
  dir.create(path = incdir, showWarnings = FALSE, recursive = TRUE)
  
  rdir <- file.path(bookdown_dir, script_dir)
  dir.create(path = rdir, showWarnings = FALSE, recursive = TRUE)
  
  # add or update helper files
  file.copy(css, incdir, overwrite = TRUE)
  file.copy(js, incdir, overwrite = TRUE)
  file.copy(script, rdir, overwrite = TRUE)
  message("webex.css, webex.js, and webex.R updated")
  
  # add index file if needed
  file.copy(index, bookdown_dir, overwrite = FALSE)
  
  # update or create _output.yml
  output_defaults <- list(
    "bookdown::bs4_book" = list(
      df_print = "kable",
      theme = list(primary = "#0d6efd"),
      lib_dir = "libs",
      split_bib = FALSE
    ),
    "bookdown::gitbook" = list(
      df_print = "kable",
      number_sections = TRUE,
      self_contained = FALSE,
      highlight = "default",
      config = list(
        toc = list(
          collapse = "subsection",
          scroll_highlight = TRUE,
          before = NULL,
          after = NULL
        ),
        edit = NULL,
        download = NULL,
        fontsettings = list(
          theme = "white",
          family = "sans",
          size = 2),
        info = TRUE
      )
    ),
    "bookdown::html_book" = list(
      theme = "default",
      highlight = "default",
      split_by = "chapter",
      toc = FALSE
    ),
    "bookdown::tufte_html_book" = list(
      toc = FALSE
    )
  )
  
  output_file <- file.path(bookdown_dir, "_output.yml")
  if (!file.exists(output_file)) {
    # add new format with reasonable defaults
    yml <- list()
    yml[[output_format]] <- output_defaults[[output_format]]
  } else {
    # keep default yml
    yml <- yaml::read_yaml(output_file)
    if (!output_format %in% names(yml)) {
      # append output_format
      yml[[output_format]] <- output_defaults[[output_format]]
    }
  }
  
  # get previous values
  old_css <- yml[[output_format]]$css
  old_js <- yml[[output_format]]$includes$after_body
  old_md <- yml[[output_format]]$md_extensions
  
  # merge with new values
  yml[[output_format]]$css <- union(old_css, file.path(include_dir, "webex.css"))
  yml[[output_format]]$includes$after_body <- union(old_js, file.path(include_dir, "webex.js"))
  yml[[output_format]]$md_extensions <- union(old_md, "-smart")
  
  # write to _output.yml
  yaml::write_yaml(yml, output_file)
  message(output_file, " updated")
  
  # update or create _bookdown.yml
  bookdown_file <- file.path(bookdown_dir, "_bookdown.yml")
  if (file.exists(bookdown_file)) {
    yml <- yaml::read_yaml(bookdown_file)
  } else {
    # set reasonable defaults
    yml <- list(book_filename = "_main",
                new_session = "yes",
                output_dir = "docs",
                delete_merged_file = "yes")
  }
  
  # get previous values
  old_bcs <- yml$before_chapter_script
  yml$before_chapter_script <- union(old_bcs, file.path(script_dir, "webex.R"))
  # write to _bookdown.yml
  yaml::write_yaml(yml, bookdown_file)
  message(bookdown_file, " updated")
  
  # render and open site
  if (isTRUE(render)) {
    if (!requireNamespace("bookdown", quietly = TRUE)) {
      stop("Package \"bookdown\" needed for this function to work. Please install it.",
           call. = FALSE)
    }
    if (!requireNamespace("xfun", quietly = TRUE)) {
      stop("Package \"xfun\" needed for this function to work. Please install it.",
           call. = FALSE)
    }
    
    local_path <- xfun::in_dir(bookdown_dir, bookdown::render_book(
      input = "index.Rmd", 
      output_format = output_format
    ))
    
    utils::browseURL(local_path)
  }
}

