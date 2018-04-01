shinycustomloader <img src="https://user-images.githubusercontent.com/7620319/38168572-71e4543e-3593-11e8-9487-9c6c484b896a.png" height="200" width="200" align="right" />
========================================================

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/shinycustomloader)](https://cran.r-project.org/package=shinycustomloader)

This R-package is an extension to the shinycssloaders package and allows for custom css/html or gif/image file for the loading screen. You may include your css/html files or gif/image files for your custom loading screen. There are twelve built in css/html loading screen specified by `dnaspin`, `pacman`, `loader1`, `loader2`,  ...,  `loader10`.

![](https://user-images.githubusercontent.com/7620319/38162692-b25596e8-3531-11e8-996b-7cceec95464d.gif)

![](https://user-images.githubusercontent.com/7620319/38162696-cafcd18e-3531-11e8-8228-f08defa97ae0.gif)

You can install this package from github as:

## Installation 

```
# You can install it from CRAN:
install.packages("shinycustomloader")

# Or the the development version from GitHub:
# install.packages("devtools")
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
![](https://user-images.githubusercontent.com/7620319/38162695-bccb7c1e-3531-11e8-90ed-168fd79b79dd.gif)

You can also further customise by inputting your own text as a `marquee` object with its own style.

![](https://user-images.githubusercontent.com/7620319/38162646-abfcb7e6-3530-11e8-9160-1e768057f32d.gif)
