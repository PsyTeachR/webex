test_that("no answer", {
  expect_error(mcq(c("A", "B")))
})

test_that("apostrophe works", {
  # new mcq function doesn't require the change
  html <- mcq(c(answer="will", "won't", "might"))
  expect_equal(grep("<option value=''>won't</option>", html, fixed = TRUE), 1L)
})

test_that("double quotes", {
  html <- mcq(c(answer="library(\"dplyr\")", "library(tidyr)"))
  expect_equal(grep("<option value='answer'>library(\"dplyr\")</option>", html, fixed = TRUE), 1L)
})
