#' Setup Conda for Bash
#'
#' Appends `Conda` settings to
#' `.bashrc` and `.condarc`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#' `.bashrc` directory.
#' Defaults to user's home directory.
#' @param overwrite Logical.
#' Overwrite existing `.bashrc` and `.condarc` files in `dir`.
#' If `TRUE` and if file/s exist/s,
#' the settings are appended to the existing file.
#' If `FALSE` and if file/s exist/s,
#' none of the settings are written on disk.
#' @param conda_path Character string.
#' Miniconda `PATH`.
#' If unspecified,
#' defaults to `{HOME}/.local/miniconda3`.
#' @param auto_activate_base Logical.
#' Auto activate base.
#' @examples
#' \dontrun{
#' term_conda(
#'   dir = getwd(),
#'   overwrite = TRUE,
#'   conda_path = file.path(
#'     Sys.getenv("HOME"),
#'     ".local",
#'     "miniconda3"
#'   ),
#'   auto_activate_base = TRUE
#' )
#' }
#' @export
term_conda <- function(dir = Sys.getenv("HOME"),
                       overwrite = FALSE,
                       conda_path = NULL,
                       auto_activate_base = FALSE) {
  if (auto_activate_base) {
    auto_activate_base <- "auto_activate_base: true"
    CONDA_AUTO_ACTIVATE_BASE <- "CONDA_AUTO_ACTIVATE_BASE=true"
  } else {
    auto_activate_base <- "auto_activate_base: false"
    CONDA_AUTO_ACTIVATE_BASE <- "CONDA_AUTO_ACTIVATE_BASE=false"
  }
  if (is.null(conda_path)) {
    conda_path <- paste0(
      file.path(
        Sys.getenv("HOME"),
        ".local",
        "miniconda3"
      )
    )
  }
  conda_path_bin <- file.path(
    conda_path,
    "bin"
  )
  export_conda_path_bin <- paste0(
    "export PATH=",
    conda_path_bin,
    ":$PATH"
  )
  conda_bashrc <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "conda",
        "bashrc",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  conda_bashrc <- gsub(
    pattern = "CONDAPATHBIN",
    replacement = conda_path_bin,
    x = conda_bashrc
  )
  conda_bashrc <- gsub(
    pattern = "CONDAPATH",
    replacement = conda_path,
    x = conda_bashrc
  )
  conda_bashrc <- paste0(
    conda_bashrc,
    "\n",
    CONDA_AUTO_ACTIVATE_BASE
  )
  ###############################################################################
  # ====[ bashrc ]===============================================================
  ###############################################################################
  bashrc <- file.path(
    dir,
    ".bashrc"
  )
  if (file.exists(bashrc)) {
    bashrc <- paste0(
      readLines(
        bashrc
      ),
      collapse = "\n"
    )
    bashrc <- gsub(
      pattern = "# >>> conda initialize >>>(.*?)# <<< conda initialize <<<",
      replacement = "",
      x = bashrc
    )
    bashrc <- gsub(
      pattern = "CONDA_AUTO_ACTIVATE_BASE=true|CONDA_AUTO_ACTIVATE_BASE=false",
      replacement = "",
      x = bashrc
    )
  } else {
    bashrc <- ""
  }
  bashrc <- paste0(
    bashrc,
    "\n\n",
    conda_bashrc
  )
  bashrc <- gsub(
    pattern = "\n{3,}",
    replacement = "\n\n",
    x = bashrc
  )
  ###############################################################################
  # ====[ condarc ]==============================================================
  ###############################################################################
  condarc <- file.path(
    dir,
    ".condarc"
  )
  if (file.exists(condarc)) {
    condarc <- readLines(
      condarc
    )
    condarc <- gsub(
      pattern = "auto_activate_base:.*?$",
      replacement = "",
      x = condarc
    )
  } else {
    condarc <- ""
  }
  condarc <- paste0(
    condarc,
    collapse = "\n"
  )
  condarc <- paste0(
    condarc,
    "\n",
    auto_activate_base
  )
  condarc <- gsub(
    pattern = "\n{3,}",
    replacement = "\n\n",
    x = condarc
  )
  util_txt2file(
    text = bashrc,
    dir = dir,
    fn = ".bashrc",
    msg = "Output file:",
    overwrite = overwrite
  )
  util_txt2file(
    text = condarc,
    dir = dir,
    fn = ".condarc",
    msg = "Output file:",
    overwrite = overwrite
  )
}
