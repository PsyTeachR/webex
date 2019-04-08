#' Create default webex document
#'
#' This function wraps \code{rmarkdown::html_document} to configure compilation to embed the default webex CSS and JavaScript files in the resulting HTML.
#'
#' @param toc Whether to include a table of contents.
#' @export
webex_default <- function(toc = FALSE) {
  css <- system.file("reports/default/webex.css", package = "webex")
  js <- system.file("reports/default/webex.js", package = "webex")

  rmarkdown::html_document(toc = toc,
                           css = css,
                           includes = rmarkdown::includes(after_body = js))
}
