#' ---
#' title: "Test: term_git_config"
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
context("Test term_git_config.")
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
