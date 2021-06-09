test_that("errors", {
  expect_error(fitb())
})

test_that("defaults", {
  # character answer
  expect_equal(
    fitb("x"), 
    "<input class='webex-solveme nospaces' size='1' data-answer='[\"x\"]'/>"
  )
  
  # vector answers
  expect_equal(
    fitb(c("x", "y")), 
    "<input class='webex-solveme nospaces' size='1' data-answer='[\"x\",\"y\"]'/>"
  )
  
  # custom width
  expect_equal(
    fitb("x", width = 5), 
    "<input class='webex-solveme nospaces' size='5' data-answer='[\"x\"]'/>"
  )
  
  # numeric NULL with leading zeroes
  expect_equal(
    fitb(0.5), 
    "<input class='webex-solveme nospaces' size='3' data-answer='[\"0.5\",\".5\"]'/>"
  )
  
  # numeric FALSE with leading zeroes
  expect_equal(
    fitb(0.5, num = FALSE), 
    "<input class='webex-solveme nospaces' size='3' data-answer='[\"0.5\"]'/>"
  )
  
  # numeric TRUE with leading zeroes
  expect_equal(
    fitb(0.5, num = TRUE), 
    "<input class='webex-solveme nospaces' size='3' data-answer='[\"0.5\",\".5\"]'/>"
  )
  
  # tolerance
  expect_equal(
    fitb(0.5, tol = 0.1), 
    "<input class='webex-solveme nospaces' data-tol='0.1' size='3' data-answer='[\"0.5\",\".5\"]'/>"
  )
  
  # ignore_case = TRUE
  expect_equal(
    fitb("x X", ignore_case = TRUE), 
    "<input class='webex-solveme nospaces ignorecase' size='3' data-answer='[\"x X\"]'/>"
  )
  
  # ignore_case = FALSE
  expect_equal(
    fitb("x X", ignore_case = FALSE), 
    "<input class='webex-solveme nospaces' size='3' data-answer='[\"x X\"]'/>"
  )
  
  # ignore_ws = FALSE
  expect_equal(
    fitb("x y", ignore_ws = FALSE), 
    "<input class='webex-solveme' size='3' data-answer='[\"x y\"]'/>"
  )
  
  # regex = TRUE
  expect_equal(
    fitb("\\d{1,4}", 4, regex = TRUE), 
    "<input class='webex-solveme nospaces regex' size='4' data-answer='[\"\\\\d{1,4}\"]'/>"
  )
})
