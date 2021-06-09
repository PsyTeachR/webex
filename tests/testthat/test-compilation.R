test_that("minimal compile", {
  ## make a temporary file
  tf <- tempfile(fileext=".Rmd")
  cat("---",
      "title: \"Web Exercises\"",
      "output: webex::webex_default",
      "---", "",
      "```{r test, webex.hide=\"click me\"}",
      "rnorm(10)",
      "```",
      file=tf,
      sep = "\n")


  ## compile it
  outfile <- rmarkdown::render(tf, quiet=TRUE)
  expect_equal(basename(outfile),
               sub("\\.Rmd$", ".html", basename(tf)))
  
  ## cleanup
  if (file.exists(tf)) file.remove(tf)
  if (file.exists(outfile)) file.remove(outfile)
})
