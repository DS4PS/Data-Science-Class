library( "rmarkdown" )
pandoc_version()

library( "bookdown" )
setwd( "C:/Users/jdlecy/Dropbox/00 - PEDA Program Design/00 - R Book/Data-Science-Class/01-TEXTBOOK" )


bookdown::render_book( "index.Rmd", "bookdown::gitbook" )
bookdown::render_book( 'index.Rmd', 'bookdown::pdf_book' )
bookdown::render_book( 'index.Rmd', 'bookdown::epub_book' )

