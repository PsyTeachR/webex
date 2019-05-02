#' Create default webex document
#'
#' This function wraps \code{rmarkdown::html_document} to configure compilation to embed the default webex CSS and JavaScript files in the resulting HTML.
#'
#' @details Call this function as the \code{output_format} argument for the \code{\link[rmarkdown]{render}} function when compiling HTML documents from RMarkdown source.
#' 
#' @param ... Additional function arguments to pass to \code{\link[rmarkdown]{html_document}}.
#' @seealso \code{\link[rmarkdown]{render}}, \code{\link[rmarkdown]{html_document}}
#' @examples
#' # copy the webex 'R Markdown' template to a temporary file
#' \dontrun{
#' my_rmd <- tempfile(fileext = ".Rmd")
#' rmarkdown::draft(my_rmd, "webex", "webex")
#'
#' # compile it
#' rmarkdown::render(my_rmd, webex::webex_default())
#' 
#' # view the result
#' browseURL(sub("\\.Rmd$", ".html", my_rmd))
#' }
#' @export
webex_default <- function(...) {
  css <- system.file("reports/default/webex.css", package = "webex")
  js <- system.file("reports/default/webex.js", package = "webex")

  knitr::knit_hooks$set(webex.hide = function(before, options, envir) {
    if (before) {
      if (is.character(options$webex.hide)) {
        hide(options$webex.hide)
      } else {
        hide()
      }
    } else {
      unhide()
    }
  })
  
  rmarkdown::html_document(css = css,
                           includes = rmarkdown::includes(after_body = js), 
                           smart = FALSE,
                           ...)
}
