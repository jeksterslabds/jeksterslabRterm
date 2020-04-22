#' ---
#' title: "Test: term_rprofile"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ setup
library(testthat)
library(jeksterslabRterm)
context("Test term_rprofile.")
#'
#' ## Set test parameters
#'
#+ parameters
dir <- getwd()
fn_rprofile <- file.path(
  dir,
  ".Rprofile"
)
#'
#' ## Run test
#'
#+ test
term_rprofile(
  dir = dir,
  overwrite = TRUE
)
#'
#+ testthat_01, echo=TRUE
test_that(".Rprofile", {
  expect_true(
    file.exists(fn_rprofile)
  )
})
#'
#+ testthat_01, echo=TRUE
test_that("warnings", {
  expect_warning(
    term_rprofile(
      dir = dir,
      overwrite = FALSE
    )
  )
})
#'
#+ cleanup
unlink(
  fn_rprofile
)
