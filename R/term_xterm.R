#' Create Xterm .Xresources
#'
#' Creates `Xterm` `.Xresources` in the home directory.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   `.Xresources` directory.
#'   Defaults to user's home directory.
#' @param overwrite Logical.
#'   Overwrite existing `.Xresources` dot files in the home directory.
#' @param dark Logical.
#'   Dark color scheme.
#' @examples
#' \dontrun{
#' term_xterm(
#'   dir = getwd(),
#'   overwrite = TRUE,
#'   dark = TRUE
#' )
#' }
#' @export
term_xterm <- function(dir = Sys.getenv("HOME"),
                       overwrite = FALSE,
                       dark = TRUE) {
  if (util_os() == "windows") {
    stop(
      "Xterm is not avalable in Windows.\n"
    )
  }
  fn_xresources <- file.path(
    dir,
    ".Xresources"
  )
  xresources <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "Xresources",
        "Xresources",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  if (dark) {
    color <- paste0(
      readLines(
        con = system.file(
          "extdata",
          "Xresources",
          "Xresources_dark",
          package = "jeksterslabRterm",
          mustWork = TRUE
        )
      ),
      collapse = "\n"
    )
  } else {
    color <- paste0(
      readLines(
        con = system.file(
          "extdata",
          "Xresources",
          "Xresources_light",
          package = "jeksterslabRterm",
          mustWork = TRUE
        )
      ),
      collapse = "\n"
    )
  }
  output <- paste0(
    xresources,
    "\n",
    color
  )
  if (file.exists(fn_xresources)) {
    if (!overwrite) {
      return(
        message(
          paste(
            fn_xresources,
            "exists and will NOT be overwritten.\n"
          )
        )
      )
    }
  }
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".Xresources",
    msg = "Output file:"
  )
  system(
    paste(
      "xrdb",
      fn_xresources
    )
  )
}
