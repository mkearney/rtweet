test_that("search_users returns users data", {
  x <- search_users("twitter", n = 20, verbose = FALSE)
  expect_s3_class(x, "tbl_df")
  expect_equal(nrow(x), 20)
})
