# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

txt_input = function(..., width = '100%') shiny::textInput(..., width = width)

Blog_post <- function(title){
  data <- list(title = title,
               author = "Mark Edney",
               date = Sys.Date(),
               categories = list("How-to", "R", "Rmarkdown"),
               draft = FALSE,
               description = "''",
               image = "''",
               archives = format(date, "%Y/%m"),
               toc = 'false',
               fold = "show",
               tools = 'true',
               link =  'false')

  Template <- '---
title: {{title}}
author: {{author}}
date: {{date}}
categories: [{{categories}}]
draft: {{draft}}
description: {{description}}
image: {{image}}
archives:
  - {{archives}}
toc: {{toc}}

format:
  html:
    code-fold: {{fold}}
    code-tools: {{tools}}
---

# Introduction

# Conclusion

'

  dir.create(paste0("./posts/",data$date, "-", title))
  writeLines(whisker::whisker.render(Template, data), paste0("./posts/",data$date, "-", title, "/index.qmd"))
}
