#' Reset R User Library.
#'
#' Resets the R user library by doing the following:
#' - removes contents of R user library (`libpath`) and
#' - executes `term_user_lib`
#' **WARNING:**
#' This function
#' **permanently deletes files in `libpath`**.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams term_user_lib
#' @export
term_reset_user_lib <- function(libpath = NULL,
                                dir = Sys.getenv("HOME"),
                                overwrite = TRUE) {
  libpath <- suppressMessages(
    term_user_lib(
      libpath = libpath,
      dir = dir,
      overwrite = overwrite
    )
  )
  unlink(
    libpath,
    recursive = TRUE
  )
  term_user_lib(
    libpath = dir,
    overwrite = overwrite
  )
}
