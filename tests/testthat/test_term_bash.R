#' ---
#' title: "Test: term_bash"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: term_bash}
#'   %\VignetteEngine{knitr::rmarkdown}
#'   %\VignetteEncoding{UTF-8}
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
context("Test term_bash.")
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
fn_bashrc <- file.path(
  tmp,
  ".bashrc"
)
fn_bash_aliases <- file.path(
  tmp,
  ".bash_aliases"
)
fn_bash_profile <- file.path(
  tmp,
  ".bash_profile"
)
fn_bash_logout <- file.path(
  tmp,
  ".bash_logout"
)
os <- util_os()
#'
#' ## Run test
#'
#+ test
if (os != "windows") {
  term_bash(
    dir = tmp,
    overwrite = TRUE,
    vars = c(GITHUB_PAT = "123456", TRAVIS_TOKEN = "123456")
  )
}

#+ testthat_01, echo=TRUE
if (os != "windows") {
  test_that(".bashrc", {
    expect_true(
      file.exists(fn_bashrc)
    )
  })
}
#+ testthat_02, echo=TRUE
if (os != "windows") {
  test_that(".bash_aliases", {
    expect_true(
      file.exists(fn_bash_aliases)
    )
  })
}
#+ testthat_03, echo=TRUE
if (os != "windows") {
  test_that(".bash_profile", {
    expect_true(
      file.exists(fn_bash_profile)
    )
  })
}
#+ testthat_04, echo=TRUE
if (os != "windows") {
  test_that(".bash_logout", {
    expect_true(
      file.exists(fn_bash_logout)
    )
  })
}
#+ testthat_05, echo=TRUE
if (os != "windows") {
  test_that("warning", {
    expect_warning(
      term_bash(
        dir = tmp,
        overwrite = FALSE,
        vars = c(GITHUB_PAT = "123456", TRAVIS_TOKEN = "123456")
      )
    )
  })
}
#'
#+ testthat_06, echo=TRUE
if (os == "windows") {
  test_that("windows", {
    expect_error(
      term_bash(
        dir = tmp,
        overwrite = FALSE,
        vars = c(GITHUB_PAT = "123456", TRAVIS_TOKEN = "123456")
      )
    )
  })
}
#'
#+ cleanup
unlink(
  c(
    fn_bashrc,
    fn_bash_aliases,
    fn_bash_profile,
    fn_bash_logout,
    tmp
  ),
  recursive = TRUE
)
