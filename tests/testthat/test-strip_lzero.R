context("test-strip_lzero")

test_that("strip", {
  expect_equal(strip_lzero("0.01"), ".01")
  expect_equal(strip_lzero("0.551"), ".551")
  expect_equal(strip_lzero(0.01), ".01")
  expect_equal(strip_lzero(0.551), ".551")
})

test_that("nostrip", {
  expect_equal(strip_lzero("01"), "01")
  expect_equal(strip_lzero("010.1"), "010.1")
  expect_equal(strip_lzero("001"), "001")
})
