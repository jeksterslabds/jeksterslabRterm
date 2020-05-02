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
#' @export
term_bash <- function(dir = Sys.getenv("HOME"),
                      overwrite = FALSE,
                      vars = NULL) {
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
  if (file.exists(fn_bashrc)) {
    if (!overwrite) {
      message(
        paste(
          fn_bashrc,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_rc,
    dir = dir,
    fn = ".bashrc",
    msg = "Output file:"
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
  if (file.exists(fn_bash_aliases)) {
    if (!overwrite) {
      message(
        paste(
          fn_bash_aliases,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_aliases,
    dir = dir,
    fn = ".bash_aliases",
    msg = "Output file:"
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
  if (file.exists(fn_bash_profile)) {
    if (!overwrite) {
      message(
        paste(
          fn_bash_profile,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_profile,
    dir = dir,
    fn = ".bash_profile",
    msg = "Output file:"
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
  if (file.exists(fn_bash_logout)) {
    if (!overwrite) {
      message(
        paste(
          fn_bash_logout,
          "exists and will NOT be overwritten.\n"
        )
      )
    }
  }
  util_txt2file(
    text = bash_logout,
    dir = dir,
    fn = ".bash_logout",
    msg = "Output file:"
  )
}
