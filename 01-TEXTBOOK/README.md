This is a minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown). 

Please see the page "[Get Started](https://bookdown.org/yihui/bookdown/get-started.html)" at https://bookdown.org/yihui/bookdown/ for how to compile this example into HTML. 

```r

# make sure you have a valid version of pandoc installed:
library( "rmarkdown" )
pandoc_version()

library( "bookdown" )
setwd( "C:/Users/username/YourDirectoryAddressHere" )

bookdown::render_book( "index.Rmd", "bookdown::gitbook" )
bookdown::render_book( 'index.Rmd', 'bookdown::pdf_book' )
bookdown::render_book( 'index.Rmd', 'bookdown::epub_book' )

```

More detailed instructions are available here https://bookdown.org/yihui/bookdown/build-the-book.html.

You can find the preview of this example at https://bookdown.org/yihui/bookdown-demo/.
