# Options
options(menu.graphics = FALSE)
# Set repos
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com/"
  options(repos = r)
})
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
        require(
          "colorout"
        )
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
