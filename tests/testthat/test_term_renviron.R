#' ---
#' title: "Test: term_renviron"
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
context("Test term_renviron.")
#'
#' ## Set test parameters
#'
#+ parameters
dir <- file.path(
  getwd(),
  "tmp"
)
fn_renviron <- file.path(
  dir,
  ".Renviron"
)
#'
#' ## Run test
#'
#+ test
term_renviron(
  dir = dir,
  overwrite = TRUE,
  GITHUB_PAT = "123456",
  libpath = file.path(dir, "tmp")
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
#+ testthat_01, echo=TRUE
test_that("messages", {
  expect_message(
    term_renviron(
      dir = dir,
      overwrite = FALSE,
      GITHUB_PAT = "123456",
      libpath = file.path(dir, "tmp")
    )
  )
})
#'
#+ cleanup
unlink(
  c(
    fn_renviron,
    dir
  ),
  recursive = TRUE
)
