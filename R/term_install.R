#' Install Terminal Tools
#'
#' Installs terminal tools.
#' Uses package managers to install packages
#' (`pacman` for Arch Linux based Linux Distributions,
#' `apt` for Debian based Linux Distributions,
#' `hombrew` for Mac OSX and
#' `chocolatey` for Windows.)
#'
#' NOTE: `chocolatey` for Windows is not currently implemented.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param ... Arguments to pass to [`term_brew`].
#' @inheritParams term_brew
#' @examples
#' \dontrun{
#' term_install()
#' }
#' @importFrom jeksterslabRutils util_distro
#' @export
term_install <- function(packages,
                         ...) {
  os <- util_distro()
  if (os == "osx") {
    term_brew(
      packages = packages,
      ...
    )
  }
  if (os == "windows") {
    # chocolatey
  }
  if (os == "linux") {
    # apt
    # pacman
    # yum
  }
}
