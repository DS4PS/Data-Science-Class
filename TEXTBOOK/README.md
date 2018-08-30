# Creating a Textbook with Bookdown

This is a minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown). 

This example is built using the following R markdown files: 

* index.Rmd
* Unit-01-Introduction-to-R.Rmd 
* Unit-02-Data-Structures.Rmd 
* Unit-03-Merging-Data.Rmd 
* Unit-04-Analysis-with-Groups.Rmd 

The *index.Rmd* file is the only abnormal Rmd file. It contains the basic info about the book (title, author, etc.) and whatever text is included on the introduction to the text. Here is the current *index.Rmd* file:

```
--- 
title: "Foundations of Data Science I"
author: "Jesse Lecy"
date: "`r format(Sys.time(), '%d %B, %Y')`"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "This is a minimal example of using the bookdown package to write a book. The output format for this example is bookdown::gitbook."
---

# Prerequisites

This is a _sample_ book written in **Markdown**. You can use anything that Pandoc's Markdown supports, e.g., a math equation $a^2 + b^2 = c^2$.

Remember each Rmd file contains one and only one chapter, and a chapter is defined by the first-level heading `#`.

To compile this example to PDF, you need XeLaTeX. You are recommended to install TinyTeX (which includes XeLaTeX): <https://yihui.name/tinytex/>.

```

The images are all in the "figures" folder.

The rest of the files are provided by a Bookdown template. You don't need to understand the details, but they need to be included in the folder when you compile the Rmd files into the book.


# YAML Files

The **bookdown** package uses a couple of YAML files to set build parameters. All of these settings are documented in the help file, but we can use the same files for most cases.

## _bookdown.yml

Sets parameters about where output goes and how the build manages files.
```
book_filename: "DS4PS"
language:
  ui:
    chapter_name: "Chapter "
delete_merged_file: true
output_dir: "docs"
```

## _output.yml

Sets parameters about the look of the book.

```
bookdown::gitbook:
  css: custom.css
  config:
    toc:
      before: |
        <li><a href="./">Data Science I</a></li>
      after: |
        <li><a href="https://webapp4.asu.edu/programs/t5/majorinfo/ASU00/PPPGEMS/graduate/false" target="blank">ASU</a></li>
    edit: https://github.com/rstudio/bookdown-demo/edit/master/%s
    download: ["pdf","epub"]
bookdown::pdf_book:
  includes:
    in_header: preamble.tex
  latex_engine: xelatex
  citation_package: natbib
  keep_tex: yes
bookdown::epub_book: default
```

# Building the Book

When the lecture notes are all ready the book is built using the following code:

```r
library( "bookdown" )
setwd( "C:/Users/username/YourDirectoryAddressHere" )

bookdown::render_book( "index.Rmd", "bookdown::gitbook" )
bookdown::render_book( 'index.Rmd', 'bookdown::pdf_book' )
bookdown::render_book( 'index.Rmd', 'bookdown::epub_book' )

```

After these files are all built, you can click on the "index.html" file in the docs folder to launch the site. 


## Pandoc

If you run into problems compiling, it might be a result of having an older version of Pandoc on your machine. Make sure you have a recent version of pandoc installed, which you can check by:

```r
library( "rmarkdown" )
pandoc_version()
```


# Images

You can insert images eithr with traditional markdown or HTML syntax. 

It is recommended, however, to use the include_graphics() function in **knitr** because it plays well with bookdown and allows you to create figure captions and re-size easily. 

Other options may not render correctly if you change the output format between HTML and PDF, for example. 

````markdown

```{r knitr-logo, out.width='32.8%', fig.show='hold', fig.cap='Three knitr logos included in the document from an external PNG image file.'}
knitr::include_graphics('images/knit-logo.png')
```
````

### Text references (from bookdown documentation)

You can assign some text to a label and reference the text using the label elsewhere in your document. This can be particularly useful for long figure/table captions (Section \@ref(figures) and \@ref(tables)), in which case you normally will have to write the whole character string in the chunk header (e.g., `fig.cap = "A long long figure caption."`) or your R code (e.g., `kable(caption = "A long long table caption.")`). It is also useful when these captions contain special HTML or LaTeX characters, e.g., if the figure caption contains an underscore, it works in the HTML output but may not work in LaTeX output because the underscore must be escaped in LaTeX.

The syntax for a text reference is `(ref:label) text`, where `label` is a unique label^[You may consider using the code chunk labels.] throughout the document for `text`. It must be in a separate paragraph with empty lines above and below it. The paragraph must not be wrapped into multiple lines, and should not end with a white space. For example,

```markdown
(ref:foo) Define a text reference **here**. 
```

Then you can use `(ref:foo)` in your figure/table captions. The text can contain anything that Markdown supports, as long as it is one single paragraph. Here is a complete example:

````markdown
A normal paragraph.

(ref:foo) A scatterplot of the data `cars` using **base** R graphics. 

`r ''````{r foo, fig.cap='(ref:foo)'}
plot(cars)  # a scatterplot
```
````

Text references can be used anywhere in the document (not limited to figure captions). It can also be useful if you want to reuse a fragment of text in multiple places.

[More examples](https://raw.githubusercontent.com/rstudio/bookdown/master/inst/examples/02-components.Rmd)


# Tables

Similar to images, the kable() function in **knitr** will render properly in most cases and allows you to add a caption. When rendered, tables will be automatically numbered for you. 

````markdown
```{r table-single, tidy=FALSE}
knitr::kable(
  head(mtcars[, 1:8], 10), booktabs = TRUE,
  caption = 'A table of the first 10 rows of the mtcars data.'
)
```
````

You can also reference table numbers using `\@ref(tab:chunk-name)`. For example, instead of writing, "In Table 6" you would use the relative reference in case the chapters or tables are re-ordered. 

So, for example, the table above would be referenced by `\@ref(tab:table-single)` since the code chunk is named "table-single". 

# Documentation

Please see the page "[Get Started](https://bookdown.org/yihui/bookdown/get-started.html)" at https://bookdown.org/yihui/bookdown/ for basic instructions. 

More detailed instructions are available here https://bookdown.org/yihui/bookdown/build-the-book.html.

You can find the preview of this example at https://bookdown.org/yihui/bookdown-demo/.
