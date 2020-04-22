#' ---
#' title: "Test: term_user_lib"
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
context("Test term_user_lib.")
#'
#' ## Set test parameters
#'
#+ parameters
dir <- getwd()
fn_renviron <- file.path(
  dir,
  ".Renviron"
)
# The library path is set to `{HOME}/R/{PLATFORM}-library/{R.VERSION}`
platform <- R.version[["platform"]]
major <- R.version[["major"]]
minor <- sub(
  pattern = ".[1-9]",
  replacement = "",
  R.version[["minor"]]
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
    platform,
    "-library"
  ),
  version
)
init <- dir.exists(libpath)
#'
#' ## Run test
#'
#+ test
term_user_lib(
  dir = dir
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
  fn_renviron
)
if (!init) {
  unlink(
    libpath,
    recursive = TRUE
  )
}
