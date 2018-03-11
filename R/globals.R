.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(prefix="assets", directoryPath=system.file("assets", package="shinycustomloader"))
  shiny::addResourcePath(prefix="css-loaders", directoryPath=system.file("css-loaders", package="shinycustomloader"))
}
