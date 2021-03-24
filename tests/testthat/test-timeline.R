test_that("get_timeline", {
  n <- 400
  x <- get_timeline(c("cnnbrk", "cnn"), n = n)
  expect_true(is.data.frame(x))
  expect_named(x)
  expect_true("status_id" %in% names(x))
  expect_gt(nrow(x), 100)
  expect_gt(ncol(x), 25)
  xts <- ts_data(x, by = "days")
  expect_true(is.data.frame(xts))
  p <- ts_plot(xts)
  #expect_true(inherits(p, "ggplot"))
  #if (requireNamespace("ggplot2", quietly = TRUE)) {
  g <- readRDS("g.rds")
  p <- ts_plot(g, "hours", trim = 1)
    expect_true(inherits(p, "ggplot"))
  d <- ts_data(g, "hours", trim = 1)
  expect_true(is.data.frame(d))
  #expect_equal(ncol(d), 4)
  unlink("Rplots.pdf")
})

test_that("get_timelines() is deprecated", {
  expect_snapshot(x <- get_timelines("cnn", n = 10))
})