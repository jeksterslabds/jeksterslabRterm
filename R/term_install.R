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
#' @param ... Arguments to pass to [`term_brew()`], or [`term_apt()`].
#' @inheritParams term_brew
#' @examples
#' \dontrun{
#' term_install()
#' }
#' @importFrom jeksterslabRutils util_distro
#' @export
term_install <- function(packages,
                         ...) {
  os <- util_os()
  if (os == "osx") {
    term_brew(
      packages = packages,
      ...
    )
  }
  if (os == "windows") {
    term_choco(
      packages = packages
    )
  }
  if (os == "linux") {
    distro <- util_distro()
    # apt
    if (distro == "debian") {
      package_manager <- "apt"
    }
    if (distro == "ubuntu") {
      package_manager <- "apt"
    }
    # pacman
    if (distro == "arch linux") {
      package_manager <- "pacman"
    }
    # yum
    if (package_manager == "pacman") {
      term_pacman(
        packages = packages
      )
    }
    if (package_manager == "apt") {
      term_apt(
        packages = packages,
        ...
      )
    }
  }
}
