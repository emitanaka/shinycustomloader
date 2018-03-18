# shinycustomloader

This R-package is an extension to the shinycssloaders package and allows for custom css/html or gif/image file for the loading screen. You may include your css/html files or gif/image files for your custom loading screen. There are twelve built in css/html loading screen specified by `dnaspin`, `pacman`, `loader1`, `loader2`,  ...,  `loader10`.

![](example.gif)

![](standard.gif)

You can install this package from github as:

## Installation 

```
devtools::install_github('emitanaka/shinycustomloader')
```

## Example 

You can see an example shiny app that employs the custom loaders by launching an example app in the package.

```
library(shinycustomloader)
shinyExample()

```
## Customisation

The command is a simple wrapper for the shiny output and you can easily specify your own favorite gif (say `nyancat.gif`) for customisation. Place `nyancat.gif` in the folder `www` within your shiny app folder (create one if you don't have it in your shiny folder).

```
withLoader(plotOutput("distPlot"), type="image", loader="nyancat.gif")
```
![](nyancat.gif)

You can also further customise by inputting your own text as a `marquee` object with its own style.

![](customtext.gif)