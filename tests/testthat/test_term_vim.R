#' ---
#' title: "Test: term_vim"
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
context("Test term_vim.")
#'
#' ## Set test parameters
#'
#+ parameters
dir <- getwd()
fn_vimrc <- file.path(
  dir,
  ".vimrc"
)
#'
#' ## Run test
#'
#+ test
term_vim(
  dir = dir,
  overwrite = TRUE,
  plugins = FALSE
)
#+ testthat_01, echo=TRUE
test_that(".vimrc", {
  expect_true(
    file.exists(fn_vimrc)
  )
})
#+ testthat_02, echo=TRUE
test_that("messages", {
  expect_message(
    term_vim(
      dir = dir,
      overwrite = FALSE,
      plugins = FALSE
    )
  )
})
#'
#+ cleanup
unlink(
  fn_vimrc
)
