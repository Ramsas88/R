library(shiny)
library(DT)
library(haven)
library(shinyFeedback)

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Display SAS dataset"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      #input: Path
      textInput(inputId="path",
                label = "Enter the study path",
                #value="D:/R/CDISC_Study/data/adam"
                placeholder = "Enter Valid SAS data path"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "data",
                  label = "Choose a dataset:",
                  choices = NULL),
      # add load button
      actionButton("load","Display Data")
      #list files
      #column(6,verbatimTextOutput("from"))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      #renderDataTable(outputId = "table")
      DT::dataTableOutput("table")
    )
  )
)

# Define server  ----

server <- function(input, output,session) {
  observeEvent(input$path,
               {
                 if (!is.null(input$path)){
                   datasets <- list.files(input$path, pattern="*.sas7bdat")
                   updateSelectInput(session,inputId = "data",choices=datasets)
                 }
               }
  )
  
  
  observeEvent(input$load,{
    
    outtable <- haven::read_sas(file.path(input$path,input$data))
    output$table = DT::renderDataTable({
      datatable(outtable,filter = "top", options=list(searching=T,
                                                      pageLength=5,
                                                      lengthMenu=c(5,10,20),
                                                      scrollX=T))
    })
  })
  
  
}
shinyApp(ui, server)
