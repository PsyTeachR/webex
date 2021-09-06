test_that("no answer", {
  expect_error(longmcq(c("A", "B")))
})

test_that("apostrophe works", {
  html <- longmcq(c(answer="will", "won't", "might"))
  expect_equal(grep("<span>won&apos;t</span>", html, fixed = TRUE), 1L)
})
