# shinycustomloader

This R-package is an extension to the shinycssloaders package and allows for custom css/html or gif/image file for the loading screen. You may include your css/html files or gif/image files for your custom loading screen. There are four built in css/html loading screen specified by `dnaspin`, `dancingtree`, `pacman` and `walkingcow`.

![](example.gif)

You can install this package from github as:


```
devtools::install_github('emitanaka/shinycustomloader')
```

You can see an example shiny app that employs the custom loaders by launching an example app in the package.

```
library(shinycustomloader)
shinyExample()

```

The command is a simple wrapper for the shiny output and you can easily specify your own favorite gif (say `tree.gif`) for customisation. Place `tree.gif` in the folder `www` within your shiny app folder (create one if you don't have it in your shiny folder).

```
withLoader(plotOutput("distPlot"), type="image", loader="tree.gif")
```
