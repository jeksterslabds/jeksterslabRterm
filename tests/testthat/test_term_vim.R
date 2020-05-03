#' ---
#' title: "Test: term_vim"
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
context("Test term_vim.")
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
fn_vimrc <- file.path(
  tmp,
  ".vimrc"
)
#'
#' ## Run test
#'
#+ test
term_vim(
  dir = tmp,
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
test_that("warning", {
  expect_warning(
    term_vim(
      dir = tmp,
      overwrite = FALSE,
      plugins = FALSE
    )
  )
})
#'
#+ cleanup
unlink(
  c(
    fn_vimrc,
    tmp
  ),
  recursive = TRUE
)
