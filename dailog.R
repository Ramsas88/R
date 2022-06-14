
library(shiny)
library(shinyFeedback)

ui <- fluidPage(
  fluidRow(column(4, actionButton("delete", "Delete all files?"))),
  br(),
  fluidRow(column(4, actionButton("copy", "Copy all files?")))
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
      actionButton("cancel1", "Cancel"),
      actionButton("ok1", "Delete", class = "btn btn-danger")
    )
  )
  observeEvent(input$ok1, {
    showNotification("Files deleted")
    removeModal()
  })
  observeEvent(input$cancel1, {
    removeModal()
  })
  
  # copy files
  observeEvent(input$copy, {
    showModal(modal_copy)
  })
  #Copy dialog box
  modal_copy <- modalDialog(
    "Are you sure you want to continue?",
    title = "Copy files",
    footer = tagList(
      actionButton("cancel2", "Cancel"),
      actionButton("ok2", "Copy", class = "btn-success")
    )
  )
  observeEvent(input$ok2, {
    showNotification("Files Copied")
    removeModal()
  })
  observeEvent(input$cancel2, {
    removeModal()
  })
  
}

shinyApp(ui, server)
