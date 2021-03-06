test_that("list_statuses() works with either id or slug + owner_user", {
  x <- lists_statuses("105140588")
  expect_s3_class(x, "data.frame")
  
  x <- lists_statuses(slug = "senators", owner_user = "cspan")
  expect_s3_class(x, "data.frame")
})
