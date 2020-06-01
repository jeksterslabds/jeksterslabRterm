#' Chocolatey
#'
#' Installs packages on Windows using Chocolatey.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams term_brew
#' @export
term_choco <- function(packages) {
  packages <- paste0(
    packages,
    collapse = " "
  )
  system(
    "choco upgrade all"
  )
  system(
    paste(
      "choco install",
      packages
    )
  )
}
