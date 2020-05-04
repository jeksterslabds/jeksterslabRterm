#' Reset R User Library.
#'
#' Resets the R user library by doing the following:
#' - removes contents of R user library (`{HOME}/R/{PLATFORM}/{R.VERSION}`) and
#' - executes `term_user_lib` with arguments
#'   `libpath = NULL`,
#'   `dir = Sys.getenv("HOME")`, and
#'   `overwrite = TRUE`.
#' **WARNING:**
#' This function
#' **permanently deletes files in `{HOME}/R/{PLATFORM}/{R.VERSION}`**.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams term_user_lib
#' @export
term_reset_user_lib <- function() {
  ###########################################################
  # arguments are hard coded to prevent accidental clobbering
  libpath <- NULL
  dir <- Sys.getenv("HOME")
  overwrite <- TRUE
  ###########################################################
  libpath <- suppressMessages(
    term_user_lib(
      libpath = libpath,
      dir = dir,
      overwrite = overwrite
    )
  )
  exit_code <- unlink(
    libpath,
    recursive = TRUE
  )
  if (exit_code > 0) {
    stop(
      paste0(
        "unlink(",
        "\"",
        libpath,
        "\"",
        ", recursive = TRUE)",
        " returned an error.\n"
      )
    )
  }
  term_user_lib(
    libpath = libpath,
    dir = dir,
    overwrite = overwrite
  )
  message(
    paste(
      libpath,
      "was emptied.\n"
    )
  )
}
