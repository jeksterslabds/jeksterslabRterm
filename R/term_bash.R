#' Setup Bash dotfiles
#'
#' Creates the following files:
#' `.bashrc`,
#' `.bash_aliases`,
#' `.bash_profile`,
#' `.bash_logout`
#'  in `dir`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   `.bash*` directory.
#'   Defaults to user's home directory.
#' @param overwrite Logical.
#'   Overwrite existing `bash` dot files in `dir`.
#' @param vars Named character vector.
#'   Variables to export.
#'   (e.g., `vars = c(GITHUB_PAT = "token_here", TRAVIS_TOKEN = "token_here")`.
#' @param conda Logical.
#'   Add Miniconda `PATH` to `.bashrc`.
#' @param conda_path Character string.
#'   Miniconda `PATH`.
#'   If unspecified,
#'   defaults to
#'   `{HOME}/.local/miniconda3/bin`.
#' @examples
#' \dontrun{
#' term_bash(
#'   dir = getwd(),
#'   overwrite = TRUE,
#'   vars = c(
#'     GITHUB_PAT = "123456",
#'     TRAVIS_TOKEN = "123456"
#'   )
#' )
#' }
#' @importFrom curl curl_download
#' @export
term_bash <- function(dir = Sys.getenv("HOME"),
                      overwrite = FALSE,
                      vars = NULL,
                      conda = FALSE,
                      conda_path = NULL) {
  if (util_os() == "windows") {
    stop(
      "Bash is not avalable in Windows.\n"
    )
  }
  ###############################################################################
  # ====[ bashrc ]===============================================================
  ###############################################################################
  fn_bashrc <- file.path(
    dir,
    ".bashrc"
  )
  bash_prompt <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_prompt",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  bash_var <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_var",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  bash_set <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_set",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  bash_path <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_path",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  if (conda) {
    if (is.null(conda_path)) {
      conda_path <- paste0(
        file.path(
          Sys.getenv("HOME"),
          ".local",
          "miniconda3",
          "bin"
        )
      )
    }
    conda_path <- paste0(
      "export PATH=",
      conda_path,
      ":$PATH"
    )
    bash_path <- paste0(
      bash_path,
      "\n",
      conda_path
    )
    # paste0(
    #  "eval \"$(",
    #  file.path(
    #    conda_path,
    #    "conda"
    #  ),
    #  " shell.bash hook)"
    # )
  }
  neofetch <- "[ -x \"$(command -v neofetch)\" ] && neofetch"
  global <- paste0(
    "################################################################################\n",
    "#====[ Source global definitions if any ]=======================================\n",
    "################################################################################\n",
    "[ -f /etc/bashrc ] && . /etc/bashrc\n"
  )
  aliases <- paste0(
    "################################################################################\n",
    "#====[ Source aliases if any ]==================================================\n",
    "################################################################################\n",
    "[ -f ~/.bash_aliases ] && . ~/.bash_aliases\n"
  )
  if (!is.null(vars)) {
    vars_names <- names(vars)
    vars <- paste0(
      "\n",
      "export ",
      vars_names,
      "=",
      vars
    )
    bash_var <- paste0(
      bash_var,
      "\n",
      "# From vars",
      paste0(
        vars,
        collapse = ""
      )
    )
  }
  bash_rc <- paste(
    neofetch,
    global,
    aliases,
    bash_prompt,
    bash_var,
    bash_set,
    bash_path,
    sep = "\n\n"
  )
  util_txt2file(
    text = bash_rc,
    dir = dir,
    fn = ".bashrc",
    msg = "Output file:",
    overwrite = overwrite
  )
  ###############################################################################
  # ====[ bash_aliases ]=========================================================
  ###############################################################################
  fn_bash_aliases <- file.path(
    dir,
    ".bash_aliases"
  )
  bash_aliases <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_aliases",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  util_txt2file(
    text = bash_aliases,
    dir = dir,
    fn = ".bash_aliases",
    msg = "Output file:",
    overwrite = overwrite
  )
  ###############################################################################
  # ====[ bash_profile ]=========================================================
  ###############################################################################
  fn_bash_profile <- file.path(
    dir,
    ".bash_profile"
  )
  bash_profile <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_profile",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  destfile <- file.path(
    dir,
    ".git-completion.bash"
  )
  curl_download(
    url = "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash",
    destfile = destfile
  )
  bash_profile <- paste0(
    bash_profile,
    "\n",
    "if [ -f ",
    destfile,
    " ]; then",
    "\n",
    "\t", ". ", destfile,
    "\n",
    "fi"
  )
  util_txt2file(
    text = bash_profile,
    dir = dir,
    fn = ".bash_profile",
    msg = "Output file:",
    overwrite = overwrite
  )

  ###############################################################################
  # ====[ bash_logout ]==========================================================
  ###############################################################################
  fn_bash_logout <- file.path(
    dir,
    ".bash_logout"
  )
  bash_logout <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "bash",
        "bash_logout",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  util_txt2file(
    text = bash_logout,
    dir = dir,
    fn = ".bash_logout",
    msg = "Output file:",
    overwrite = overwrite
  )
}
