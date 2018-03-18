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

prismDependencies <- tags$head(
  tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/prism/1.8.4/prism.min.js"),
  tags$link(rel = "stylesheet", type = "text/css",
            href = "https://cdnjs.cloudflare.com/ajax/libs/prism/1.8.4/themes/prism.min.css")
)

prismRDependency <- tags$head(
  tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/prism/1.8.4/components/prism-r.min.js")
)


ui <- dashboardPage(
  dashboardHeader(title = "Shiny Custom Loaders"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("DEMO: Spinning DNA", tabName = "dnaspin"),
      menuItem("DEMO: Pacman", tabName = "pacman"),
      menuItem("Standard loaders", tabName = "standard"),
      menuItem("Custom TEXT", tabName = "customtext"),
      menuItem("Custom CSS/HTML", tabName = "customcss"),
      menuItem("Custom GIF/IMAGE", tabName = "customgif")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dnaspin",
              h2("Spinning DNA"),
              fluidRow(prismDependencies,
                       prismRDependency,
HTML("<pre><code class='language-r'>withLoader(plotOutput(\"distPlot\"), type=\"html\", loader=\"dnaspin\")
                             </code></pre>")),
              fluidRow(
                box(
                  title = "With Loader", status = "primary", solidHeader = TRUE,
                  withLoader(plotOutput("distPlot"), type="html", loader="dnaspin")
                ),
                box(
                  title = "Without Loader", status = "warning", solidHeader = TRUE,
                  plotOutput("distPlot2")
                )
              )
      ),
      tabItem(tabName = "pacman",
              h2("Pacman"),
              fluidRow(prismDependencies,
                       prismRDependency,
                       HTML("<pre><code class='language-r'>withLoader(plotOutput(\"distPlot\"), type=\"html\", loader=\"pacman\")
                            </code></pre>")),
              fluidRow(
                box(
                  title = "With Loader", status = "primary", solidHeader = TRUE,
                  withLoader(plotOutput("distPlot5"), type="html", loader="pacman")
                ),
                box(
                  title = "Without Loader", status = "warning", solidHeader = TRUE,
                  plotOutput("distPlot6")
                )
              )
      ),
tabItem(tabName = "standard",
        h2("Standard Loaders"),
        fluidRow(prismDependencies,
                 prismRDependency,
                 HTML("<pre><code class='language-r'>withLoader(plotOutput(\"distPlot\"), type=\"html\", loader=\"loader1\")
                      </code></pre>")),
        fluidRow(
          shiny::div(style="transform: translateY(150px)", renderCSS("html", "loaders"))
        )
                 ),
tabItem(tabName = "customtext",
                h2("Custom Text"),
                fluidRow(prismDependencies,
                         prismRDependency,
                         HTML("<pre><code class='language-r'>withLoader(plotOutput(\"distPlot\"), type=\"text\",
            loader=list(marquee(\"Your custom text here\"),
                        marquee(\"You can change the speed\", scrollamount=20),
                        marquee(\"Direction can be customised too!\", direction=\"right\")
                        marquee(\"Style it as you want\", style=\"font-size:40px; color:blue\"),
                        marquee(\"Up, up and away\", direction=\"up\", style=\"font-size:20px; color:green\", height=\"100px\"),
                        marquee(\"Bouncy bounce\", behavior=\"alternate\", scrollamount=15)))
                              </code></pre>")),
                fluidRow(
                  column(3),
                  box(
                    title = "With custom text", status = "primary", solidHeader = TRUE,
                    shiny::div(style="width:100%; height:400px; text-align:center; top: 20%; transform: translateY(20%);", renderCSS(type="text", loader=list(marquee("Your custom text here"),
                                                       marquee("You can change the speed", scrollamount=20),
                                                       marquee("Direction can be customised too", direction="right"),
                                                       marquee("Style it as you want", style="font-size:40px; color:blue"),
                                                       marquee("Up, up and away", direction="up", style="font-size:20px; color:green", height="100px"),
                                                       marquee("Bouncy bounce", behavior="alternate", scrollamount=15))))
                  )
                )
      ),
tabItem(tabName = "customcss",
        h2("Custom CSS/HTML"),
        fluidRow(prismDependencies,
                 prismRDependency,
                 HTML("<pre><code class='language-r'>withLoader(plotOutput(\"distPlot\"), type=\"html\", loader=\"usyddna\")
                      </code></pre>")),
        HTML("<b>How to set up</b>"), HTML("<p>Place your <code>css</code> and <code>html</code> file in the <code>www</code> folder of your shiny folder making sure they are the same name.</p>"),
        HTML("You can download the example <a href=\"usyddna.css\" download>usyddna.css</a> and <a href=\"usyddna.html\" download>usyddna.html</a>."),
        HTML("For more examples you can find it <a href=\"https://codepen.io/\" target=\"_blank\">here</a>."),
        h5(),
        fluidRow(
          column(3),
          box(
            title = "With custom css/html", status = "primary", solidHeader = TRUE,
            shiny::div(style="width:100%; height:400px; text-align:center; top: 40%; transform: translateY(40%);", renderCSS(type="html", loader="usyddna"))
          )
        )
                      ),
tabItem(tabName = "customgif",
        h2("Custom GIF/IMAGE"),
        fluidRow(prismDependencies,
                 prismRDependency,
                 HTML("<pre><code class='language-r'>withLoader(plotOutput(\"distPlot\"), type=\"image\", loader=\"nyancat.gif\")
                      </code></pre>")),
        HTML("<b>How to set up</b>"), HTML("<p>Place your <code>gif</code> or <code>image</code> file in the <code>www</code> folder of your shiny folder.</p>"),
        fluidRow(
          column(3),
          box(
            title = "With custom gif/image", status = "primary", solidHeader = TRUE,
            shiny::img(class = "loader-img", src = "nyancat.gif", style="top: 50%; transform: translateY(50%);"), height="400px"
          )
        )
)
      )))


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

