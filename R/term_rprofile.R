#' Create `.Rprofile` File
#'
#' Creates a `.Rprofile` file in `dir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#' `.Rprofile` directory
#' @param overwrite Logical.
#' Overwrite existing `.Rprofile` file in `dir`.
#' @examples
#' \dontrun{
#' term_rprofile(
#'   dir = getwd(),
#'   overwrite = TRUE
#' )
#' }
#' @export
term_rprofile <- function(dir = Sys.getenv("HOME"),
                          overwrite = FALSE) {
  rprofile <- file.path(
    dir,
    ".Rprofile"
  )
  output <- readLines(
    con = system.file(
      "extdata",
      "Rextras",
      "Rprofile.R",
      package = "jeksterslabRterm",
      mustWork = TRUE
    )
  )
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".Rprofile",
    msg = "Output file:",
    overwrite = overwrite
  )
}
