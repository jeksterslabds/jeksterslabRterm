#' Create `.vimrc` File and Install Plugins
#'
#' Creates a `.vimrc` file in `dir`
#' and installs plugins.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param dir Character string.
#'   `.vimrc` directory
#' @param overwrite Logical.
#'   Overwrite existing `.vimrc` file in `dir`.
#' @param plugins Logical.
#'   Install `vim` plugins.
#' @param dark Logical.
#'   Dark background.
#' @param colorscheme Character string.
#' @examples
#' \dontrun{
#' term_vim(
#'   dir = getwd(),
#'   overwrite = TRUE,
#'   plugins = TRUE
#' )
#' }
#' @export
term_vim <- function(dir = Sys.getenv("HOME"),
                     overwrite = FALSE,
                     plugins = FALSE,
                     dark = TRUE,
                     colorscheme = "default") {
  vimrc <- file.path(
    dir,
    ".vimrc"
  )
  output <- paste0(
    readLines(
      con = system.file(
        "extdata",
        "vim",
        "vimrc",
        package = "jeksterslabRterm",
        mustWork = TRUE
      )
    ),
    collapse = "\n"
  )
  if (dark) {
    background <- "dark"
  } else {
    background <- "light"
  }
  colorscheme <- paste0(
    "\"====[ Colorscheme ]===========================================================", "\n",
    "set background=", background, "\n",
    "colorscheme ", colorscheme
  )
  output <- paste0(
    output,
    "\n\n",
    colorscheme
  )
  util_txt2file(
    text = output,
    dir = dir,
    fn = ".vimrc",
    msg = "Output file:",
    overwrite = overwrite
  )
  if (plugins) {
    vimplugins <- system.file(
      "extdata",
      "vim",
      "vim-plugins",
      package = "jeksterslabRterm",
      mustWork = TRUE
    )
    system(
      paste(
        "bash",
        vimplugins
      )
    )
  }
}
