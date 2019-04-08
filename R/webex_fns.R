#' Create fill-in-the-blank question
#'
#' @param answer The correct answer
#' @param width Width of the input box in characters. Defaults to the length of the longest answer.
#' @param num whether the input is numeric, in which case allow for leading zeroes to be omitted
#' @param tol the tolerance within which numeric answers will be accepts; i.e. (response - true.answer) < tol = a correct response. Implies num=TRUE
#' @param ignore_case Whether to ignore case (capitalization)
#' @param ignore_ws Whether to ignore white space
#' @param regex Whether to use regex to match answers (concatenates all answers with `|` before matching)
#' @details Writes html code that creates an input box widget. Call this function inline in an RMarkdown document. See the Web Exercises RMarkdown template for examples.
#' @export
fitb <- function(answer, width = calculated_width, 
                 num = FALSE,
                 ignore_case = FALSE,
                 tol=NULL,
                 ignore_ws = TRUE, regex=FALSE) {
  
  
  if(!is.null(tol)){
    num <- TRUE
  } 

  if (num) {
    answer2 <- strip_lzero(answer)
    answer <- union(answer, answer2)
  }
  
  # if width not set, calculate it from max length answer, up to limit of 100
  calculated_width <- min(100, max(nchar(answer)))
  
  answers <- jsonlite::toJSON(as.character(answer))
  paste0("<input class='solveme",
         ifelse(ignore_ws, " nospaces", ""),
         ifelse(!is.null(tol), paste0("' data-tol='", tol, ""), ""),
         ifelse(ignore_case, " ignorecase", ""),
         ifelse(regex, " regex", ""),
         "' size='", width,
         "' data-answer='", answers, "'/>")
}

#' Create multiple choice question
#'
#' @param opts Vector of alternatives. The correct answer is the element(s) of this vector named 'answer'. See the Web Exercises RMarkdown template for examples.
#' @details Writes html code that creates an option box widget. Call this function inline in an RMarkdown document. See the Web Exercises RMarkdown template for examples.
#' @export
mcq <- function(opts) {
  ix <- which(names(opts) == "answer")
  if (length(ix) == 0) {
    stop("MCQ has no correct answer")
  }
  answers <- jsonlite::toJSON(as.character(opts[ix]))
  options <- paste0(" <option>",
                    paste(c("", opts), collapse = "</option> <option>"),
                    "</option>")
  paste0("<select class='solveme' data-answer='", answers, "'>",
         options, "</select>")
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
  paste0("\n<div class='solution'><button>", button_text, "</button>\n")
}

#' End hidden HTML content
#'
#' @seealso \code{hide}
#' @details Call this function inline in an RMarkdown document to mark the end of hidden content (see the Web Exercises RMarkdown Template for examples).
#' @export
unhide <- function() {
  paste0("\n</div>\n")
}

#' Change webex widget style
#'
#' @param default the colour of the widgets when the correct answer is not filled in (defaults to blue)
#' @param correct the colour of the widgets when the correct answer not filled in (defaults to red)
#' @details Call this function inline in an RMarkdown document to change the default and correct colours using any valid HTML colour word (e.g., red, rgb(255,0,0), hsl(0, 100%, 50%) or #FF0000).
#' @export
widget_style <- function(default = "blue", correct = "red") {
  paste0(
    "\n<style>\n",
    "    .solveme { border-color: ", default,"; }\n",
    "    .solveme.correct { border-color: ", correct,"; }\n",
    "</style>\n\n"
  )
}

#' Round up from .5
#'
#' @param x a numeric string (or number that can be converted to a string)
#' @param digits integer indicating the number of decimal places (`round`) or significant digits (`signif`) to be used.
#' @details Implements rounding using the "round up from .5" rule, which is more conventional than the "round to even" rule implemented by R's built-in \code{\link{round}} function. This implementation was taken from (https://stackoverflow.com/a/12688836).
#' @export
round2 = function(x, digits = 0) {
  posneg = sign(x)
  z = abs(x)*10^digits
  z = z + 0.5
  z = trunc(z)
  z = z/10^digits
  z*posneg
}

#' Strip leading zero from numeric string
#'
#' @param x a numeric string (or number that can be converted to a string)
#' @return a string with leading zero removed
#' @export
strip_lzero <- function(x) {
  sub("^([+-]*)0\\.", "\\1.", x)
}
