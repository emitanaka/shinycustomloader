#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinycustomloader)

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Custom Loaders"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Spinning DNA", tabName = "dnaspin", icon = icon("DNA")),
      menuItem("Dancing Tree", tabName = "dancingtree", icon = icon("tree")),
      menuItem("Pacman", tabName = "pacman", icon = icon("codiepie")),
      menuItem("Walking Cow", tabName = "walkingcow", icon = icon("bell")),
      menuItem("Growing Tree", tabName = "tree", icon = icon("tree-alt"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dnaspin",
              h2("Spinning DNA"),
              fluidRow(
                box(
                  title = "With Loader", status = "primary", solidHeader = TRUE,
                  withLoader(plotOutput("distPlot"), type="html", loader="dnaspin")
                ),
                box(
                  title = "Without Loader", status = "warning", solidHeader = TRUE,
                  plotOutput("distPlot2")
                )
              ),
              fluidRow(box(
                title = "Code", status = "primary",
                HTML("<code>withLoader(plotOutput(`distPlot`), type=`html`, loader=`dnaspin`)</code>")
              ))
      ),
      tabItem(tabName = "dancingtree",
              h2("Dancing Tree"),
              fluidRow(
                box(
                  title = "With Loader", status = "primary", solidHeader = TRUE,
                  withLoader(plotOutput("distPlot3"), type="html", loader="dancingtree")
                ),
                box(
                  title = "Without Loader", status = "warning", solidHeader = TRUE,
                  plotOutput("distPlot4")
                )
              ),
              fluidRow(box(
                title = "Code", status = "primary",
                HTML("<code>withLoader(plotOutput(`distPlot`), type=`html`, loader=`dancingtree`)</code>")
              ))
      ),
      tabItem(tabName = "pacman",
              h2("Pacman"),
              fluidRow(
                box(
                  title = "With Loader", status = "primary", solidHeader = TRUE,
                  withLoader(plotOutput("distPlot5"), type="html", loader="pacman")
                ),
                box(
                  title = "Without Loader", status = "warning", solidHeader = TRUE,
                  plotOutput("distPlot6")
                )
              ),
              fluidRow(box(
                title = "Code", status = "primary",
                HTML("<code>withLoader(plotOutput(`distPlot`), type=`html`, loader=`pacman`)</code>")
              ))
      ),
      tabItem(tabName = "walkingcow",
              h2("Walking Cow"),
              fluidRow(
                box(
                  title = "With Loader", status = "primary", solidHeader = TRUE,
                  withLoader(plotOutput("distPlot7"), type="html", loader="walkingcow")
                ),
                box(
                  title = "Without Loader", status = "warning", solidHeader = TRUE,
                  plotOutput("distPlot8")
                )
              ),
              fluidRow(box(
                title = "Code", status = "primary",
                HTML("<code>withLoader(plotOutput(`distPlot`), type=`html`, loader=`walkingcow`)</code>")
              ))
      ),
      tabItem(tabName = "tree",
              h2("Tree"),
              fluidRow(
                box(
                  title = "With Loader", status = "primary", solidHeader = TRUE,
                  withLoader(plotOutput("distPlot9"), type="image", loader="tree.gif")
                ),
                box(
                  title = "Without Loader", status = "warning", solidHeader = TRUE,
                  plotOutput("distPlot10")
                )
              ),
              fluidRow(box(
                title = "Code", status = "primary",
                HTML("Use your own gif or image by setting type=\"image\" and specify your own gif or image including the extension of the file.\n"),
                HTML("<code>withLoader(plotOutput(`distPlot`), type=`image`, loader=`tree.gif`)</code>")
              ))
      )
    )
  )

)

getHist <- function(){
  x    <- faithful[, 2]
  bins <- seq(min(x), max(x), length.out =  8)
  Sys.sleep(3)
  hist(x, breaks = bins, col = 'darkgray', border = 'white')
}

server <- function(input, output) {

  output$distPlot <- renderPlot(getHist())
  output$distPlot2 <- renderPlot(getHist())
  output$distPlot3 <- renderPlot(getHist())
  output$distPlot4 <- renderPlot(getHist())
  output$distPlot5 <- renderPlot(getHist())
  output$distPlot6 <- renderPlot(getHist())
  output$distPlot7 <- renderPlot(getHist())
  output$distPlot8 <- renderPlot(getHist())
  output$distPlot9 <- renderPlot(getHist())
  output$distPlot10 <- renderPlot(getHist())

}

# Run the application
shinyApp(ui = ui, server = server)

