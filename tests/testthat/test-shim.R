context("test-shim.R")

test_that("shimmed arguments match unshimmed", {
  expect_equal(formals(shim_require), formals(require))
  expect_equal(formals(shim_library), formals(library))
})

test_that("shims load package with conflicts silently", {
  red <- function() {}

  expect_message(shim_library(crayon), NA)
  detach("package:crayon")

  expect_message(shim_require(crayon, quietly = TRUE), NA)
  detach("package:crayon")
})

# package_name ------------------------------------------------------------

test_that("package_name mimics library", {
  expect_equal(package_name(quo(ggplot2)), "ggplot2")

  x <- "ggplot2"
  expect_equal(package_name(quo(x), TRUE), "ggplot2")
})

test_that("package_name throws errors with invalid names" ,{
  x <- c("x", "y")
  expect_error(package_name(quo(x), TRUE), "character vector")

  x <- 1:10
  expect_error(package_name(quo(x), TRUE), "character vector")

  x <- NA_character_
  expect_error(package_name(quo(x), TRUE), "NA")

  x <- ""
  expect_error(package_name(quo(x), TRUE), "''")
})
