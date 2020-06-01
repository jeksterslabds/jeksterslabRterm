#' Apt
#'
#' Installs packages on Debian based Linux distributions.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param ppa Character vector.
#'   Personal Package Archives (PPA) to add.
#' @inheritParams term_brew
#' @export
term_apt <- function(packages, ppa = NULL) {
  packages <- paste0(
    packages,
    collapse = " "
  )
  if (is.null(ppa)) {
    ppa <- paste0(
      "ppa:",
      ppa
    )
    ppa <- paste0(
      ppa,
      collapse = " "
    )
    system(
      "sudo add-apt-repository -y",
      ppa
    )
  }
  system(
    "sudo apt update -y"
  )
  system(
    "sudo apt upgrade -y"
  )
  system(
    paste(
      "sudo apt install -y",
      packages
    )
  )
}
