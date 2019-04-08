context("test-round2")

test_that("round up", {
  expect_equal(round2(0.5), 1)
  expect_equal(round2(1.5), 2)
  expect_equal(round2(2.5), 3)
  expect_equal(round2(-0.5), -1)
})

test_that("round down", {
  expect_equal(round2(0.45), 0)
  expect_equal(round2(1.45), 1)
  expect_equal(round2(2.45), 2)
  expect_equal(round2(-0.45), 0)
})

test_that("digits", { 
  expect_equal(round2(.05, 1), .1)
  expect_equal(round2(.15, 1), .2)
  expect_equal(round2(.25, 1), .3)
})

