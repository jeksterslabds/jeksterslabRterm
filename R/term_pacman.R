#' Pacman
#'
#' Installs packages on Arch Linux based Linux distributions.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @inheritParams term_brew
#' @export
term_pacman <- function(packages) {
  packages <- paste0(
    packages,
    collapse = " "
  )
  system(
    "sudo pacman -Syu --noconfirm"
  )
  system(
    paste(
      "sudo pacman -S --needed --noconfirm",
      packages
    )
  )
}
