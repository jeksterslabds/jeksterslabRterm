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
#' @examples
#' \dontrun{
#' term_install()
#' }
#' @export
term_install <- function() {
  os <- util_os()
  if (os == "linux") {
    foo <- function(pattern, x) {
      any(
        grepl(
          pattern = pattern,
          x = x
        )
      )
    }
    x <- readLines("/etc/os-release")
    pattern <- c(
      "[A|a]rch [L|l]inux",
      "[U|u]buntu",
      "[D|d]ebian"
    )
    distro <- lapply(
      X = pattern,
      FUN = foo,
      x = x
    )
    packages <- c(
      "neofetch",
      "wget",
      "git",
      "bash-completion",
      "xterm",
      "ttf-liberation",
      "tmux",
      "gvim"
    )
    packages <- paste0(
      packages,
      collapse = " "
    )
    install <- c(
      "sudo pacman -Syu --needed --noconfirm",
      "sudo apt update && sudo apt install",
      "sudo apt update && sudo apt install"
    )
    for (i in seq_along(distro)) {
      if (distro[i] == TRUE) {
        system(
          paste(
            install[i],
            packages
          )
        )
      }
    }
  }
  if (os == "osx") {
    brew <- c(
      "neofetch",
      "wget",
      "git",
      "bash-completion",
      "xterm",
      "tmux",
      "gvim"
    )
    brew <- paste0(
      brew,
      collapse = "\n"
    )
    cask <- c(
      "font-liberation-sans"
    )
    cask <- paste0(
      cask,
      collapse = "\n"
    )
    system(
      paste(
        "brew install",
        brew
      )
    )
    system(
      paste(
        "brew cask install",
        cask
      )
    )
  }
  if (os == "windows") {
    # chocolatey
  }
}
