#' Set User Library
#'
#' Sets user library using `.libPaths`
#' and `R_LIBS_USER` in `.Renviron`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param libpath Character string.
#'   User library path.
#'   If unspecified, defaults to
#'   and returns the absolute path of
#'   `{HOME}/R/{PLATFORM}-library/{R.VERSION}`.
#' @param overwrite Logical.
#'   If `.Renviron` exists in `dir`,
#'   the variable `R_LIBS_USER`
#'   is overwritten
#'   with  `R_LIBS_USER="{libpath}"`.
#'   This argument is set to `TRUE`
#'   to ensure that the specified `libpath`
#'   is reflected in the `.Renviron` in `dir`.
#' @inheritParams term_renviron
#' @examples
#' \dontrun{
#' term_user_lib(
#'   libpath = file.path(getwd(), "lib"),
#'   dir = getwd()
#' )
#' }
#' @importFrom jeksterslabRutils util_txt2file
#' @export
term_user_lib <- function(libpath = NULL,
                          dir = Sys.getenv("HOME"),
                          overwrite = TRUE) {
  if (is.null(libpath)) {
    # The library path is set to `{HOME}/R/{PLATFORM}-library/{R.VERSION}`
    platform <- R.version[["platform"]]
    major <- R.version[["major"]]
    minor <- sub(
      pattern = "^(\\d+)\\.\\d+$",
      replacement = "\\1",
      x = R.version[["minor"]]
    )
    version <- paste0(
      major,
      ".",
      minor
    )
    libpath <- file.path(
      Sys.getenv("HOME"),
      "R",
      paste0(
        platform,
        "-library"
      ),
      version
    )
    out <- TRUE
  } else {
    out <- FALSE
  }
  if (!dir.exists(libpath)) {
    dir.create(
      libpath,
      recursive = TRUE
    )
  }
  .libPaths(
    unique(
      c(
        libpath,
        .libPaths()
      )
    )
  )
  R_LIBS_USER <- paste0(
    "R_LIBS_USER",
    "=",
    "\"",
    libpath,
    "\""
  )
  cat(
    paste(
      "Library path:",
      libpath,
      "\n"
    )
  )
  # Generate `{HOME}/.Renviron` with the environment variable `R_LIBS_USER={HOME}/R/{PLATFORM}-library/{R.VERSION}`.
  renviron <- file.path(
    dir,
    ".Renviron"
  )
  if (file.exists(renviron)) {
    content <- readLines(renviron)
    pattern <- "^R_LIBS_USER=.*"
    if (
      any(
        grepl(
          pattern = pattern,
          x = content
        )
      )
    ) {
      R_LIBS_USER <- sub(
        pattern = pattern,
        replacement = R_LIBS_USER,
        x = content
      )
    } else {
      R_LIBS_USER <- paste(
        R_LIBS_USER,
        paste0(
          content,
          collapse = "\n"
        ),
        sep = "\n"
      )
    }
  }
  util_txt2file(
    text = R_LIBS_USER,
    dir = dir,
    fn = ".Renviron",
    msg = "Added R_LIBS_USER to",
    overwrite = overwrite
  )
  if (out) {
    return(
      normalizePath(
        libpath
      )
    )
  }
}
