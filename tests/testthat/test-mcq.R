test_that("apostrophe works", {
  expect_equal(mcq(c("will", answer="won't", "might")),
               "<select class='webex-solveme' data-answer='[\"won&apos;t\"]'> <option></option> <option>will</option> <option>won&apos;t</option> <option>might</option></select>")
})
