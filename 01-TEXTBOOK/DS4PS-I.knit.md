--- 
title: "Foundations of Data Science I"
author: "Jesse Lecy"
date: "31 July, 2018"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: "This is a minimal example of using the bookdown package to write a book. The output format for this example is bookdown::gitbook."
---

# Prerequisites

Placeholder



<!--chapter:end:index.Rmd-->


# Introduction to R

Placeholder


## Navigation
### Setting Your Working Directory
## Commenting Code
##  Here is some documentation for this script
## Help
## Install Programs (packages)
## Accessing Built-In Datasets in R
### Basic Data Operations
### Using the Lahman Data
### Example Analysis

<!--chapter:end:Unit-01-Introduction-to-R.Rmd-->

# Data Structures






## Vectors

Vectors are the building blocks of data programming in R, so they are extremely important concepts. 

Very loosely speaking a vector is a set of numbers or words. For example, *[ 1, 2, 3]* or *[ apple, orange, pear ]*. In social science, a vector is a variable in a dataset.

You will spend a lot of time creating data vectors, transforming variables, generating subsets, cleaning data, and adding new observations. These are all accomplished through operators (commands) that act on vectors.

There are four primary vector types ("classes") in R: 


Class      | Description
---------- | -----------
numeric    | Typical variable of only numbers
character  | A vector of letters or words, always enclosed with quotes
factor     | Categories which represent groups, like treatment and control
logical    | A vector of TRUE and FALSE to designate which observations fit a criteria

Each vector or dataset has a "class" that tells R the data type.

These different vectors can be combined into three different types of datasets (data frames, matrices, and lists), which will be discussed below.


```r
x1 <- c(167,185,119,142)

x2 <- c("adam","jamal","linda","sriti")

x3 <- factor( c("male","male","female","female") )

x4 <- c( "treatment","control","treatment","control" )

x5 <- x4 == "treatment"

dat <- data.frame( name=x2, sex=x3, treat=x4, is.treat=x5, strength=x1 )
```





















































































