#' ---
#' title: "Test: term_user_lib"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output: rmarkdown::html_vignette
#' vignette: >
#'   %\VignetteIndexEntry{Test: term_user_lib}
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
context("Test term_user_lib.")
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
# The library path is set to `{HOME}/R/{PLATFORM}-library/{R.VERSION}`
platform <- R.version[["platform"]]
major <- R.version[["major"]]
minor <- sub(
  pattern = "^(\\d+)\\.\\d+$",
  replacement = "\\1",
  x = R.version[["minor"]]
)
version <- paste0(
  major,
  ".",
  minor
)
libpath <- file.path(
  Sys.getenv("HOME"),
  "R",
  paste0(
    platform
  ),
  version
)
init <- dir.exists(libpath)
#'
#' ## Run test
#'
#+ test
term_user_lib(
  dir = tmp
)
#'
#+ testthat_01, echo=TRUE
test_that(".Renviron", {
  expect_true(
    file.exists(fn_renviron)
  )
})
#'
#+ cleanup
unlink(
  c(
    fn_renviron,
    tmp
  ),
  recursive = TRUE
)
if (!init) {
  unlink(
    libpath,
    recursive = TRUE
  )
}
