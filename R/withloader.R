#' Add a loader that shows when an output is recalculating
#' @export
#' @param ui_element A UI element that should be wrapped with a loader when the corresponding output is being calculated.
#' @param type The type of loader to use. Possible values are image, html or text.
#' @param loader The name of the loader. The built in options are dnaspin, dancingtree, pacman and walkingcow.
#' For custom html option, the name of the css and html file have to be the same and input must be without the extension.
#' For custom image option, the name must include the extension of the file.
#' For custom text option, loader must be a list of marquee objects.
#' @param proxy.height If the output doesn't specify the output height, you can set a proxy height. It defaults to 400px for outputs with undefined height.
#' @references
#' `shinycssloaders` https://github.com/andrewsali/shinycssloaders
#'
#' `dnaspin` https://codepen.io/jsnanigans/pen/ORNJNp
#'
#' `pacman` https://codepen.io/wifi/pen/olKxE
#'
#' `loaders` https://codepen.io/Manoz/pen/pydxK
#'
#' @examples
#' \dontrun{withLoader(plotOutput("my_plot"))}
#' \dontrun{marquee_list <- list(marquee("Your custom text here"))}
#' \dontrun{withLoader(plotOutput("distPlot"), type="text", loader=marquee_list)}
withLoader <- function(ui_element,
                        type="html",
                        loader="dnaspin",
                        proxy.height = if (grepl("height:\\s*\\d", ui_element)) NULL else "400px")
{
  stopifnot(type %in% c("html", "image", "text"))

  #id <- paste0("loader-", digest::digest(ui_element))
  #add_style <- function(x) {
  #  shiny::tags$head(shiny::tags$style(shiny::HTML(x)))
  #}
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
    if(loader %in% c("dnaspin", "pacman", "loader1", "loader2", "loader3", "loader4", "loader5",
                     "loader6", "loader7", "loader8", "loader9", "loader10")) {
      htmlfile <- system.file(package='shinycustomloader', paste0("css-loaders/html/", loader, ".html"))
      shiny::tagList(shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = "assets/imgcustom-loader.css"))),
                     shiny::singleton(shiny::tags$script(src = "assets/imgcustom-loader.js")),
                     shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = "css-loaders/css/imgcustom-fallback.css"))),
                     shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = paste0("css-loaders/css/", loader, ".css")))),
                     shiny::div(class = "shiny-loader-output-container",
                                shiny::div(class = "load-container", shiny::includeHTML(htmlfile)),
                                proxy_element, ui_element))
    } else {
      htmlfile <- paste0("", loader, ".html")
      shiny::tagList(shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = "assets/imgcustom-loader.css"))),
                     shiny::singleton(shiny::tags$script(src = "assets/imgcustom-loader.js")),
                     shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = "css-loaders/css/imgcustom-fallback.css"))),
                     shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = paste0(loader, ".css")))),
                     shiny::div(class = "shiny-loader-output-container",
                                shiny::div(class = "load-container", shiny::includeHTML(htmlfile)),
                                proxy_element, ui_element))
    }
  } else if(type=="text") {
    if(!is.list(loader)) {
      textout <- "<marquee behavior=\"scroll\" direction=\"left\" scrollamount=\"1\" width=\"100%\">Loading...</marquee>
    <marquee behavior=\"scroll\" direction=\"down\" scrollamount=\"20\" height=\"50px\" width=\"100%\">Loading</marquee>
      <marquee behavior=\"scroll\" direction=\"right\" scrollamount=\"20\" width=\"100%\">Loading!</marquee>
      <marquee behavior=\"scroll\" direction=\"left\" scrollamount=\"100\" width=\"100%\">Loading</marquee>"
    } else {
      textout <- ""
      for(amarquee in loader) {
        textout <- paste0(textout, "<marquee ")
        textout <- paste0(textout, paste0(paste0(names(amarquee)[names(amarquee)!="content"], "=\"", unlist(amarquee)[names(amarquee)!="content"], "\""), collapse=" "))
        textout <- paste0(textout, ">", amarquee[names(amarquee)=="content"], "</marquee>\n ")
      }
    }
    shiny::tagList(shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                      href = "assets/imgcustom-loader.css"))),
                   shiny::singleton(shiny::tags$script(src = "assets/imgcustom-loader.js")),
                   shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                      href = "css-loaders/css/imgcustom-fallback.css"))),
                   shiny::div(class = "shiny-loader-output-container",
                              shiny::div(class = "load-container", style="text-align:center; width:100%", shiny::HTML(textout)),
                              proxy_element, ui_element))
  }
}

#' Render a permanent loading screen.
#'
#' This function follows similar to withLoader but needs no UI element. This allows for a permanent loading screen.
#' @export
#' @param type The type of loader to use. Possible values are image, html or text.
#' @param loader The name of the loader. The built in options are dnaspin, dancingtree, pacman and walkingcow.
#' For custom html option, the name of the css and html file have to be the same and input must be without the extension.
#' For custom text option, loader must be a list of marquee objects.
#' @examples
#' \dontrun{marquee_list <- list(marquee("Your custom text here"))}
#' \dontrun{renderCSS(type="text", loader=marquee_list)}
renderCSS <- function(type, loader) {
  proxy_element <- shiny::tagList()
  if (type=="html"){
    if(loader %in% c("dnaspin", "pacman", "loader1", "loader2", "loader3", "loader4", "loader5",
                     "loader6", "loader7", "loader8", "loader9", "loader10", "loaders")) {
      htmlfile <- system.file(package='shinycustomloader', paste0("css-loaders/html/", loader, ".html"))
      shiny::tagList(shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = "assets/imgcustom-loader.css"))),
                     shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = paste0("css-loaders/css/", loader, ".css")))),
                     shiny::div(class = "shiny-loader-output-container",
                                shiny::div(class = "load-container", shiny::includeHTML(htmlfile))))
    } else {
      htmlfile <- paste0("www/", loader, ".html")
      shiny::tagList(shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = "assets/imgcustom-loader.css"))),
                     shiny::singleton(shiny::tags$head(shiny::tags$link(rel = "stylesheet",
                                                                        href = paste0(loader, ".css")))),
                     shiny::div(class = "shiny-loader-output-container",
                                shiny::div(class = "load-container", shiny::includeHTML(htmlfile))))
    }
  } else if(type=="text") {
    if(!is.list(loader)) {
      textout <- "<marquee behavior=\"scroll\" direction=\"left\" scrollamount=\"1\" width=\"100%\">Loading...</marquee>
      <marquee behavior=\"scroll\" direction=\"down\" scrollamount=\"20\" height=\"50px\" width=\"100%\">Loading</marquee>
      <marquee behavior=\"scroll\" direction=\"right\" scrollamount=\"20\" width=\"100%\">Loading!</marquee>
      <marquee behavior=\"scroll\" direction=\"left\" scrollamount=\"100\" width=\"100%\">Loading</marquee>"
    } else {
      textout <- ""
      for(amarquee in loader) {
        textout <- paste0(textout, "<marquee ")
        textout <- paste0(textout, paste0(paste0(names(amarquee)[names(amarquee)!="content"], "=\"", unlist(amarquee)[names(amarquee)!="content"], "\""), collapse=" "))
        textout <- paste0(textout, ">", amarquee[names(amarquee)=="content"], "</marquee>\n ")
      }
    }
    shiny::tagList(shiny::HTML(textout), proxy_element)
  }
}


#' Create a marquee list.
#'
#' This creates the necessary elements for marquee to make custom text loading screen.
#' This function is to be used as input list in withLoader or renderCSS functions.
#' @export
#' @param content The text content of the marquee.
#' @param behavior Sets how the text is scrolled within the marquee. Possible values are scroll, slide and alternate. If no value is specified, the default value is scroll.
#' @param direction Sets the direction of the scrolling within the marquee. Possible values are left, right, up and down. If no value is specified, the default value is left.
#' @param scrollamount Sets the amount of scrolling at each interval in pixels. The default value is 6.
#' @param width Sets the width in pixels or percentage value.
#' @param ... Other parameters passed to the marquee such as height, bgcolor.
#' @examples
#' marquee("Custom loading text here...", height=60, width=100)
marquee <- function(content, behavior="scroll", direction="left", scrollamount=6, width="100%",
                    ...) {
  ret <- list(content=content, behavior=behavior, direction=direction, scrollamount=scrollamount, width=width)
  ret <- c(ret, list(...))
  return(ret)
}

#' Example Shiny App
#'
#' Shows an example shiny app with the built-in load screens.
#' @export
#' @examples
#' \dontrun{shinyExample()}
shinyExample <- function() {
  appDir <- system.file("example", package="shinycustomloader")
  shiny::runApp(appDir, display.mode="normal")
}
