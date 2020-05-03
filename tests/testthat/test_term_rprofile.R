#' ---
#' title: "Test: term_rprofile"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ include=FALSE, cache=FALSE
knitr::opts_chunk$set(
  error = TRUE,
  collapse = TRUE,
  comment = "#>",
  out.width = "100%"
)
#'
#+ setup
library(testthat)
library(jeksterslabRterm)
library(jeksterslabRutils)
context("Test term_rprofile.")
#'
#' ## Set test parameters
#'
#+ parameters
tmp <- file.path(
  tempdir(),
  util_rand_str()
)
dir.create(tmp)
on.exit(
  unlink(
    tmp,
    recursive = TRUE
  )
)
fn_rprofile <- file.path(
  tmp,
  ".Rprofile"
)
#'
#' ## Run test
#'
#+ test
term_rprofile(
  dir = tmp,
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
#+ testthat_02, echo=TRUE
test_that("warning", {
  expect_warning(
    term_rprofile(
      dir = tmp,
      overwrite = FALSE
    )
  )
})
#'
#+ cleanup
unlink(
  c(
    fn_rprofile,
    tmp
  ),
  recursive = TRUE
)
