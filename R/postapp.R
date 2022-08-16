QGadget <- function() {
  library(shiny)
  library(miniUI)

  ui <- miniPage(
    gadgetTitleBar("Quarto Blog Post"),
    miniContentPanel(
      # Define layout, inputs, outputs
      textInput("title", "Title", placeholder = "Post Title"),
      textInput("author", "Author", placeholder = "")

    )
  )

  server <- function(input, output, session) {
    # Define reactive expressions, outputs, etc.

    # When the Done button is clicked, return a value
    observeEvent(input$done, {
      Blog_post(input$title, input$author)
      stopApp("Post Created")
    })
  }

  runGadget(ui, server, viewer = dialogViewer("Quarto Blog Post"))
}

Blog_post <- function(title, author){
  data <- list(title = title,
               author = author,
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
  file.edit(paste0("./posts/",data$date, "-", title, "/index.qmd"))
}
