# Options
options(menu.graphics = FALSE)
# Set repos
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com/"
  options(repos = r)
})
# Set library path
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
    if (Sys.getenv("TERM") == "xterm-256color") {
      if ("colorout" %in% installed) {
        suppressPackageStartupMessages(
          require(
            "colorout"
          )
        )
      }
    }
    if ("jeksterslabRpkg" %in% installed) {
      suppressPackageStartupMessages(
        require(
          "jeksterslabRpkg"
        )
      )
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
