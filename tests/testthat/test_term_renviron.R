#' ---
#' title: "Test: term_renviron"
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
context("Test term_renviron.")
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
fn_renviron <- file.path(
  tmp,
  ".Renviron"
)
libpath <- file.path(
  tmp,
  "lib"
)
#'
#' ## Run test
#'
#+ test
term_renviron(
  dir = tmp,
  overwrite = TRUE,
  GITHUB_PAT = "123456",
  libpath = libpath
)
#'
#' For code coverage.
#+ covr
suppressMessages(
  term_renviron(
    overwrite = FALSE
  )
)
#'
#+ testthat_01, echo=TRUE
test_that(".Renviron", {
  expect_true(
    file.exists(fn_renviron)
  )
})
#'
#+ testthat_02, echo=TRUE
test_that("warning", {
  expect_warning(
    term_renviron(
      dir = tmp,
      overwrite = FALSE,
      GITHUB_PAT = "123456",
      libpath = file.path(tmp, "tmp")
    )
  )
})
#'
#+ cleanup
unlink(
  c(
    fn_renviron,
    tmp,
    libpath
  ),
  recursive = TRUE
)
