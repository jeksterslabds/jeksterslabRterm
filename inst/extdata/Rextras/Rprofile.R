# Options
options(menu.graphics = FALSE)
# Set repos
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com/"
  options(repos = r)
})
# Set library path
source("https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_txt2file.R")
source("https://raw.githubusercontent.com/jeksterslabds/jeksterslabRterm/master/R/term_user_lib.R")
term_user_lib(
  libpath = NULL,
  dir = Sys.getenv("HOME"),
  overwrite = TRUE
)
.First <- function() {
  if (interactive()) {
    options(
      prompt = "[R]$ "
    )
    message(
      paste(
        R.version.string,
        Sys.time(),
        getwd(),
        sep = " | "
      )
    )
    installed <- rownames(utils::installed.packages())
    if ("jeksterslabRutils" %in% installed & "jeksterslabRpkg" %in% installed) {
      require(
        "jeksterslabRutils"
      )
      con <- "https://raw.githubusercontent.com/jeksterslabds/jeksterslabRpkg/master/R/pkg_aliases.R"
      if (util_url_exists(con)) {
        source(con)
      }
    }
    if (Sys.getenv("TERM") == "xterm-256color") {
      if ("colorout" %in% installed) {
        # suppressPackageStartupMessages(
        require(
          "colorout"
        )
        # )
      }
    }
  }
}
.Last <- function() {
  if (interactive()) {
    try(
      savehistory(
        file = file.path(
          Sys.getenv("HOME"),
          ".Rhistory"
        )
      )
    )
  }
}
