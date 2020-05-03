#' Homebrew
#'
#' Install `Homebrew` and install packages.
#'
#' @param packages Character vector.
#'   Packages to install.
#' @param cask Logical.
#'   If `TRUE`, uses `brew cask install ...`.
#'   If `FALSE`, uses `brew install ...`.
#' @param tap Character vector.
#'   Add third-party repositories.
term_brew <- function(packages,
                      cask = FALSE,
                      tap = NULL) {
  os <- util_os()
  if (os == "osx") {
    if (nchar(Sys.which("brew")) == 0) {
      # install homebrew
      system(
        "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)\""
      )
    }
    # update brew
    system(
      "brew update"
    )
    if (!is.null(tap)) {
      for (i in seq_along(tap)) {
        system(
          paste(
            "brew tap",
            tap[i]
          )
        )
      }
    }
    # upgrade packages
    system(
      "brew upgrade"
    )
    installed <- system(
      "brew list",
      intern = TRUE
    )
    pkg <- rep(
      x = NA,
      times = length(packages)
    )
    for (i in seq_along(packages)) {
      if (!packages[i] %in% installed) {
        pkg[i] <- packages[i]
      } else {
        pkg[i] <- NA
      }
    }
    pkg <- pkg[!is.na(pkg)]
    pkg <- paste0(
      pkg,
      collapse = " "
    )
    if (cask) {
      cmd <- "brew cask install"
    } else {
      cmd <- "brew install"
    }
    system(
      paste(
        cmd,
        pkg
      )
    )
  } else {
    stop(
      "The current opetating system is NOT Mac OSX.\n"
    )
  }
}
