#' Create `.Renviron` File
#'
#' Creates a `.Renviron` file in `dir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#' `.Renviron` directory.
#' Defaults to user's home directory.
#' @param overwrite Logical.
#' Overwrite existing `.Renviron` file in `dir`.
#' @param GITHUB_PAT Character string.
#' Optional argument.
#' Github Personal Access Token.
#' @inheritParams term_user_lib
#' @examples
#' \dontrun{
#' term_renviron(
#'   dir = getwd(),
#'   overwrite = TRUE,
#'   GITHUB_PAT = "123456",
#'   libpath = file.path(getwd(), "tmp")
#' )
#' }
#' @importFrom jeksterslabRutils util_os
#' @export
term_renviron <- function(dir = Sys.getenv("HOME"),
                          overwrite = FALSE,
                          GITHUB_PAT = NULL,
                          libpath = NULL) {
  renviron <- file.path(
    dir,
    ".Renviron"
  )
  R_COMPLETION <- "R_COMPLETION=TRUE"
  R_ENVIRON_USER <- paste0(
    "R_ENVIRON_USER=",
    "\"",
    dir,
    "/",
    ".Renviron",
    "\""
  )
  R_PROFILE_USER <- paste0(
    "R_PROFILE_USER=",
    "\"",
    dir,
    "/",
    ".Rprofile",
    "\""
  )
  R_HISTFILE <- paste0(
    "R_HISTFILE=",
    "\"",
    dir,
    "/",
    ".Rhistory",
    "\""
  )
  if (is.null(GITHUB_PAT)) {
    GITHUB_PAT <- ""
  } else {
    GITHUB_PAT <- paste0(
      "GITHUB_PAT=",
      GITHUB_PAT
    )
  }
  if (util_os() == "linux") {
    R_BROWSER <- "R_BROWSER=${R_BROWSER-'/usr/bin/xdg-open'}"
  } else {
    R_BROWSER <- ""
  }
  output <- paste(
    R_BROWSER,
    R_COMPLETION,
    R_ENVIRON_USER,
    R_PROFILE_USER,
    R_HISTFILE,
    GITHUB_PAT,
    sep = "\n"
  )
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".Renviron",
    msg = "Output file:",
    overwrite = overwrite
  )
  term_user_lib(
    libpath = libpath,
    dir = dir
  )
}
