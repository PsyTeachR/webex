#' Create a fill-in-the-blank question
#'
#' @param answer The correct answer (can be a vector if there is more
#'   than one correct answer).
#' @param width Width of the input box in characters. Defaults to the
#'   length of the longest answer.
#' @param num Whether the input is numeric, in which case allow for
#'   leading zeroes to be omitted. Determined from the answer data
#'   type if not specified.
#' @param tol The tolerance within which numeric answers will be
#'   accepted; i.e. if \code{abs(response - true.answer) < tol}, the
#'   answer is correct (implies \code{num=TRUE}).
#' @param ignore_case Whether to ignore case (capitalization).
#' @param ignore_ws Whether to ignore whitespace.
#' @param regex Whether to use regex to match answers (concatenates
#'   all answers with `|` before matching).
#' @details Writes html code that creates an input box widget. Call
#'   this function inline in an RMarkdown document. See the Web
#'   Exercises RMarkdown template for examples of its use in
#'   RMarkdown.
#' @examples
#' # What is 2 + 2?
#' fitb(4, num = TRUE)
#' 
#' # What was the name of the Beatles drummer?
#' fitb(c("Ringo", "Ringo Starr"), ignore_case = TRUE)
#'
#' # What is pi to three decimal places?
#' fitb(pi, num = TRUE, tol = .001)
#' @export
fitb <- function(answer, 
                 width = calculated_width, 
                 num = NULL,
                 ignore_case = FALSE,
                 tol = NULL,
                 ignore_ws = TRUE, 
                 regex = FALSE) {
  # make sure answer is a numeric or character vector
  answer <- unlist(answer)
  if (!is.vector(answer) ||
      (!is.numeric(answer) && !is.character(answer))) {
    stop("The answer must be a vector of characters or numbers.")
  }
  
  # set numeric based on data type if num is NULL
  if (is.null(num)) num <- is.numeric(answer)
  
  # if tol is set, assume numeric
  if (!is.null(tol)) num <- TRUE

  # add zero-stripped versions if numeric
  if (num) {
    answer2 <- strip_lzero(answer)
    answer <- union(answer, answer2)
  }
  
  # if width not set, calculate it from max length answer, up to limit of 100
  calculated_width <- min(100, max(nchar(answer)))
  
  answers <- jsonlite::toJSON(as.character(answer))
  answers <- gsub("\'", "&apos;", answers, fixed = TRUE)
  
  paste0("<input class='webex-solveme",
         ifelse(ignore_ws, " nospaces", ""),
         ifelse(!is.null(tol), paste0("' data-tol='", tol, ""), ""),
         ifelse(ignore_case, " ignorecase", ""),
         ifelse(regex, " regex", ""),
         "' size='", width,
         "' data-answer='", answers, "'/>")
}

#' Create a multiple-choice question
#'
#' @param opts Vector of alternatives. The correct answer is the
#'   element(s) of this vector named 'answer'.
#' @details Writes html code that creates an option box widget, with one or 
#'   more correct answers. Call this function inline in an RMarkdown document. 
#'   See the Web Exercises RMarkdown template for further examples.
#' @examples
#' # How many planets orbit closer to the sun than the Earth?
#' mcq(c(1, answer = 2, 3))
#'
#' # Which actor played Luke Skywalker in the movie Star Wars?
#' mcq(c("Alec Guinness", answer = "Mark Hamill", "Harrison Ford"))
#' @export
mcq <- function(opts) {
  ix <- which(names(opts) == "answer")
  if (length(ix) == 0) {
    stop("MCQ has no correct answer")
  }
  
  options <- sprintf("<option value='%s'>%s</option>", names(opts), opts) 
  sprintf("<select class='webex-select'><option value='blank'></option>%s</select>", 
          paste(options, collapse = ""))
}

#' Create a true-or-false question
#'
#' @param answer Logical value TRUE or FALSE, corresponding to the correct answer.
#' @details Writes html code that creates an option box widget with TRUE or FALSE as alternatives. Call this function inline in an RMarkdown document. See the Web Exercises RMarkdown template for further examples.
#' @examples
#' # True or False? 2 + 2 = 4
#' torf(TRUE)
#'
#' # True or False? The month of April has 31 days.
#' torf(FALSE)
#' @export
torf <- function(answer) {
  opts <- c("TRUE", "FALSE")
  if (answer)
    names(opts) <- c("answer", "")
  else
    names(opts) <- c("", "answer")
  mcq(opts)
}


#' Longer MCQs with Radio Buttons
#'
#' @param opts Vector of alternatives. The correct answer is the
#'   element(s) of this vector named 'answer'.
#' @details Writes html code that creates a radio button widget, with a
#'   single correct answer. This is more suitable for longer answers. Call this function inline in an RMarkdown
#'   document. See the Web Exercises RMarkdown template for further
#'   examples.
#' @examples
#' # What is a p-value?
#' opts <- c(
#'   "the probability that the null hypothesis is true",
#'   answer = paste("the probability of the observed, or more extreme, data",
#'                  "under the assumption that the null-hypothesis is true"),
#'   "the probability of making an error in your conclusion"
#' )
#' longmcq(opts)
#'
#' @export
longmcq <- function(opts) {
  ix <- which(names(opts) == "answer")
  if (length(ix) == 0) {
    stop("The question has no correct answer")
  }

  opts2 <- gsub("\'", "&apos;", opts, fixed = TRUE)
  
  # make up a name to group them
  qname <- paste0("radio_", paste(sample(LETTERS, 10, T), collapse = ""))
  options <- sprintf('<label><input type="radio" autocomplete="off" name="%s" value="%s"></input> <span>%s</span></label>', qname, names(opts), opts2)
  
  paste0("<div class='webex-radiogroup' id='", qname, "'>", 
         paste(options, collapse = ""), 
         "</div>\n")
}


#' Create button revealing hidden content
#'
#' @param button_text Text to appear on the button that reveals the hidden content.
#' @seealso \code{unhide}
#' @details Writes HTML to create a content that is revealed by a button press. Call this function inline in an RMarkdown document. Any content appearing after this call up to an inline call to \code{unhide()} will only be revealed when the user clicks the button. See the Web Exercises RMarkdown Template for examples.
#' @examples
#' # default behavior is to generate a button that says "Solution"
#' hide()
#'
#' # or the button can display custom text
#' hide("Click here for a hint")
#' @export
hide <- function(button_text = "Solution") {
  paste0("\n<div class='webex-solution'><button>", button_text, "</button>\n")
}

#' End hidden HTML content
#'
#' @seealso \code{hide}
#' @details Call this function inline in an RMarkdown document to mark the end of hidden content (see the Web Exercises RMarkdown Template for examples).
#' @examples
#' # just produce the closing </div> 
#' unhide()
#' @export
unhide <- function() {
  paste0("\n</div>\n")
}

#' Change webexercises widget style
#'
#' @param default The colour of the widgets when the correct answer is not filled in (defaults to blue).
#' @param correct The colour of the widgets when the correct answer not filled in (defaults to red).
#' @details Call this function inline in an RMarkdown document to change the default and correct colours using any valid CSS colour word (e.g., red, rgb(255,0,0), hsl(0, 100%, 50%) or #FF0000).
#' @examples
#' # change to green when correct
#' style_widgets(correct = "green")
#'
#' # yellow when unfilled, pink when correct
#' style_widgets("#FFFF00", "#FF3399")
#' @export
style_widgets <- function(default = "red", correct = "blue") {
  paste0(
    "\n<style>\n",
    "    .webex-solveme { border-color: ", default,"; }\n",
    "    .webex-solveme.webex-correct { border-color: ", correct,"; }\n",
    "</style>\n\n"
  )
}

#' Display total correct
#'
#' @param elem The html element to display (e.g., div, h3, p, span)
#' @param args Optional arguments for css classes or styles
#'
#' @return A string with the html for displaying a total correct element
#' @export
#'
#' @examples
#' total_correct()     # <div  id="total_correct"></div>
#' total_correct("h3") # <h3  id="total_correct"></h3>
#' total_correct("p", "style='color: red;'")
#' total_correct("div", "class='customclass'")
total_correct <- function(elem = "span", args = "") {
  sprintf("<%s %s id=\"webex-total_correct\"></%s>\n\n", 
              elem, args, elem)
}

#' Round up from .5
#'
#' @param x A numeric string (or number that can be converted to a string).
#' @param digits Integer indicating the number of decimal places (`round`) or significant digits (`signif`) to be used.
#' @details Implements rounding using the "round up from .5" rule, which is more conventional than the "round to even" rule implemented by R's built-in \code{\link{round}} function. This implementation was taken from \url{https://stackoverflow.com/a/12688836}.
#' @examples
#' round2(c(2, 2.5))
#' 
#' # compare to:
#' round(c(2, 2.5))
#' @export
round2 <- function(x, digits = 0) {
  posneg = sign(x)
  z = abs(x)*10^digits
  z = z + 0.5
  z = trunc(z)
  z = z/10^digits
  z*posneg
}

#' Strip leading zero from numeric string
#'
#' @param x A numeric string (or number that can be converted to a string).
#' @return A string with leading zero removed.
#' @examples
#' strip_lzero("0.05")
#' @export
strip_lzero <- function(x) {
  sub("^([+-]*)0\\.", "\\1.", x)
}

#' Escape a string for regex
#'
#' @param string A string to escape
#'
#' @return A string 
#' @export
#'
#' @examples
#' escape_regex("library(tidyverse)")
escape_regex <- function(string) {
  gsub("([.|()\\^{}+$*?]|\\[|\\])", "\\\\\\1", string)
}
