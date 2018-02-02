#' Create fill-in-the-blank question
#'
#' @param answer The correct answer
#' @param size Width of the input box in characters
#' @param ignore_case Whether to ignore case (capitalization)
#' @param ignore_ws Whether to ignore white space
#' @details Writes html code that creates an input box widget. Call this function inline in an RMarkdown document. See the Web Exercises RMarkdown template for examples.
#' @export
fitb <- function(answer, size = 3,
                       ignore_case = FALSE,
                       ignore_ws = TRUE) {
  answers <- paste(answer, collapse = " :or: ")
  paste0("<input class=\"solveme",
         ifelse(ignore_ws, " nospaces", ""),
         ifelse(ignore_case, " ignorecase", ""),
         "\" size=\"", size,
         "\" answer=\"", answers, "\"/>")
}

#' Create multiple choice question
#'
#' @param opts Vector of alternatives. The element of this vector that is named 'answer' is taken as the correct answer. See the Web Exercises RMarkdown template for examples.
#' @details Writes html code that creates an option box widget. Call this function inline in an RMarkdown document. See the Web Exercises RMarkdown template for examples.
#' @export
mcq <- function(opts) {
  ix <- which(names(opts) == "answer")
  options <- paste0("<option>",
                    paste(c("", opts), collapse = "</option>\n<option>"),
                    "</option>\n")
  paste0("<select class=\"solveme\" answer=\"", opts[["answer"]], "\">\n",
         options, "</select>\n")
}

#' Create true-or-false question
#'
#' @param answer Logical value TRUE or FALSE, corresponding to the correct answer.
#' @details Writes html code that creates an option box widget with TRUE or FALSE as alternatives. Call this function inline in an RMarkdown document. See the Web Exercises RMarkdown template for examples.
#' @export
torf <- function(answer) {
  opts <- c("TRUE", "FALSE")
  if (answer)
    names(opts) <- c("answer", "")
  else
    names(opts) <- c("", "answer")
  mcq(opts)
}

#' Create button revealing hidden HTML content
#'
#' @param button_text Text to appear on the button that reveals the hidden content
#' @seealso \code{unhide}
#' @details Writes HTML to create a content that is revealed by a button press. Call this function inline in an RMarkdown document. Any content appearing after this call up to an inline call to \code{unhide()} will only be revealed when the user clicks the button. See the Web Exercises RMarkdown Template for examples.
#' @export
hide <- function(button_text = "Solution") {
  paste0("\n<div class=\"solution\"><button>", button_text, "</button>\n")
}

#' End hidden HTML content
#'
#' @seealso \code{hide}
#' @details Call this function inline in an RMarkdown document to mark the end of hidden content (see the Web Exercises RMarkdown Template for examples).
#' @export
unhide <- function() {
  paste0("\n</div>\n")
}
