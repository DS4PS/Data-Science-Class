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

# YAML Files

The **bookdown** package uses a couple of YAML files to set build parameters. All of these settings are documented in the help file, but we can use the same files for most cases.

## _output.yml

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

Make sure you have a recent version of pandoc installed:

```r
library( "rmarkdown" )
pandoc_version()
```

When the lecture notes are all ready the book is built using the following code:

```r
library( "bookdown" )
setwd( "C:/Users/username/YourDirectoryAddressHere" )

bookdown::render_book( "index.Rmd", "bookdown::gitbook" )
bookdown::render_book( 'index.Rmd', 'bookdown::pdf_book' )
bookdown::render_book( 'index.Rmd', 'bookdown::epub_book' )

```

After these files are all built, you can click on the "index.html" file in the docs folder to launch the site. 


# Documentation

Please see the page "[Get Started](https://bookdown.org/yihui/bookdown/get-started.html)" at https://bookdown.org/yihui/bookdown/ for basic instructions. 

More detailed instructions are available here https://bookdown.org/yihui/bookdown/build-the-book.html.

You can find the preview of this example at https://bookdown.org/yihui/bookdown-demo/.
