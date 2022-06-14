

library(shiny)
library(shinyFeedback)

ui <- fluidPage(
  fluidRow(column(4, actionButton("delete", "Delete all files?"))),
  br(),
  fluidRow(column(4, offset=5, actionButton("copy", "Copy all files?")))
 )

server <- function(input, output, session) {
  

  
  
  # delete file
  observeEvent(input$delete, {
    showModal(modal_del)
  })
  #Delete dialog box
  modal_del <- modalDialog(
    "Are you sure you want to continue?",
    title = "Deleting files",
    footer = tagList(
      actionButton("cancel", "Cancel"),
      actionButton("ok", "Delete", class = "btn btn-danger")
    )
  )
  observeEvent(input$ok, {
    showNotification("Files deleted")
    removeModal()
  })
  observeEvent(input$cancel, {
    removeModal()
  });
  
  # copy files
  observeEvent(input$copy, {
    showModal(modal_copy)
  })
  #Copy dialog box
  modal_copy <- modalDialog(
    "Are you sure you want to continue?",
    title = "Copy files",
    footer = tagList(
      actionButton("cancel", "Cancel"),
      actionButton("ok", "Copy", class = "btn-success")
    )
  )
        observeEvent(input$ok, {
        showNotification("Files Copied")
        removeModal()
        })
      observeEvent(input$cancel, {
      removeModal()
      })
  
}

shinyApp(ui, server)