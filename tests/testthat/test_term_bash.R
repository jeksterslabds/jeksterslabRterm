#' ---
#' title: "Test: term_bash"
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
context("Test term_bash.")
#'
#' ## Set test parameters
#'
#+ parameters
dir <- getwd()
fn_bashrc <- file.path(
  dir,
  ".bashrc"
)
fn_bash_aliases <- file.path(
  dir,
  ".bash_aliases"
)
fn_bash_profile <- file.path(
  dir,
  ".bash_profile"
)
fn_bash_logout <- file.path(
  dir,
  ".bash_logout"
)
#'
#' ## Run test
#'
#+ test
term_bash(
  dir = dir,
  overwrite = TRUE,
  vars = c(GITHUB_PAT = "123456", TRAVIS_TOKEN = "123456")
)
#+ testthat_01, echo=TRUE
test_that(".bashrc", {
  expect_true(
    file.exists(fn_bashrc)
  )
})
#+ testthat_02, echo=TRUE
test_that(".bash_aliases", {
  expect_true(
    file.exists(fn_bash_aliases)
  )
})
#+ testthat_03, echo=TRUE
test_that(".bash_profile", {
  expect_true(
    file.exists(fn_bash_profile)
  )
})
#+ testthat_04, echo=TRUE
test_that(".bash_logout", {
  expect_true(
    file.exists(fn_bash_logout)
  )
})
#+ testthat_05, echo=TRUE
test_that("messages", {
  expect_message(
    term_bash(
      dir = dir,
      overwrite = FALSE,
      vars = c(GITHUB_PAT = "123456", TRAVIS_TOKEN = "123456")
    )
  )
})
#'
#+ cleanup
unlink(
  c(
    fn_bashrc,
    fn_bash_aliases,
    fn_bash_profile,
    fn_bash_logout
  )
)
