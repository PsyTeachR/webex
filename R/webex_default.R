#' Create default webex document
#'
#' This function wraps \code{rmarkdown::html_document} to configure compilation to embed the default webex CSS and JavaScript files in the resulting HTML.
#'
#' @param ... Additional function arguments to pass to html_document
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
