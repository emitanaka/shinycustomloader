#' Add a loader that shows when an output is recalculating
#' @export
#' @param ui_element A UI element that should be wrapped with a loader when the corresponding output is being calculated.
#' @param type The type of loader to use - either image or html.
#' @param size The size of the loader, relative to it's default size.
#' @param loader The name of the loader. The built in options are dnaspin, dancingtree, pacman and walkingcow.
#' For custom html option, the name of the css and html file have to be the same and input must be without the extension.
#' For custom image option, the name must include the extension of the file.
#' @param proxy.height If the output doesn't specify the output height, you can set a proxy height. It defaults to 400px for outputs with undefined height.
#' @references
#' `shinycssloaders` https://github.com/andrewsali/shinycssloaders
#'
#' `dnaspin` https://codepen.io/jsnanigans/pen/ORNJNp
#'
#' `pacman` https://codepen.io/wifi/pen/olKxE
#'
#' `dancingtree` https://codepen.io/yukulele/pen/KCvbi
#'
#' `walkingcow` https://codepen.io/jeremiak/pen/xGOVoe
#' @examples
#' \dontrun{withLoader(plotOutput("my_plot"))}
withLoader <- function (ui_element,
                        type="html",
                        size=1,
                        loader="dnaspin",
                        proxy.height = if (grepl("height:\\s*\\d", ui_element)) NULL else "400px")
{
  stopifnot(type %in% c("html", "image"))

  id <- paste0("loader-", digest::digest(ui_element))
  add_style <- function(x) {
    shiny::tags$head(shiny::tags$style(shiny::HTML(x)))
  }
  proxy_element <- shiny::tagList()
  if (!is.null(proxy.height)) {
    proxy_element <- shiny::div(style = glue::glue("height:{ifelse(is.null(proxy.height),'100%',proxy.height)}"),
                                class = "shiny-loader-placeholder")
  }
  if (type=="image"){
    shiny::tagList(shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                      href = "assets/imgcustom-loader.css"))), shiny::singleton(shiny::tags$script(src = "assets/imgcustom-loader.js")),
                   shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                      href = "css-loaders/css/imgcustom-fallback.css"))),
                   shiny::div(class = "shiny-loader-output-container",
                              shiny::div(class = "load-container",shiny::img(class = "loader-img", src = loader)), proxy_element, ui_element))
  }
  else if (type=="html"){
    if(loader %in% c("dnaspin", "dancingtree", "pacman", "walkingcow")) {
      htmlfile <- system.file(package='shinycustomloader', paste0("css-loaders/html/", loader, ".html"))
    } else {
      htmlfile <- paste0(loader, ".html")
    }
    shiny::tagList(shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                      href = "assets/imgcustom-loader.css"))), shiny::singleton(shiny::tags$script(src = "assets/imgcustom-loader.js")),
                   shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                      href = "css-loaders/css/imgcustom-fallback.css"))),
                   shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                      href = paste0("css-loaders/css/", loader, ".css")))),
                   shiny::div(class = "shiny-loader-output-container",
                              shiny::div(class = "load-container", includeHTML(htmlfile)),
                                         proxy_element, ui_element))
  }
}

#' Example Shiny App
#'
#' Shows an example shiny app with the built-in load screens.
#' @export
#' @examples
#' \dontrun{showExample()}
shinyExample <- function() {
  appDir <- system.file("example", package="shinycustomloader")
  shiny::runApp(appDir, display.mode="normal")
}
