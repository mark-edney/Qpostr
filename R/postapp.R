QGadget <- function() {
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Quarto Blog Post"),
    miniUI::miniContentPanel(
      shiny::textInput("title", "Title", placeholder = "Post Title"),
      shiny::textInput("author", "Author", placeholder = "")

    )
  )

  server <- function(input, output, session) {
    shiny::observeEvent(input$done, {
      Blog_post(input$title, input$author)
      stopApp("Post Created")
    })
  }

  shiny::runGadget(ui, server, viewer = shiny::dialogViewer("Quarto Blog Post"))
}

Blog_post <- function(title, author){
  data <- list(title = title,
               author = author,
               date = Sys.Date(),
               categories = list("How-to", "R", "Rmarkdown"),
               draft = 'true',
               description = "''",
               image = "''",
               archives = format(Sys.Date(), "%Y/%m"),
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
