#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
if (interactive()) {
  # Define UI for application
  ui <- fluidPage(
    
    # Application title
    titlePanel("Question 2"),
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose CSV File", accept = c("text/csv","text/comma-separated-values,text/plain", ".csv")), tags$hr(), checkboxInput("header", "Header", TRUE),
        selectInput("var", "Select a Column:", c("ID" = "patient_ID", "Age" = "patient_age", "Height" = "patient_height", "Weight" = "patient_weight", "Bmi" = "patient_bmi")),
        radioButtons("cols", "Colours", c("Red" = "red","Blue" = "blue","Orange" = "orange", "Yellow" = "yellow", "Navy" = "navy"))),
      
      mainPanel(
        tableOutput("data"),
        plotOutput("box")
      )))
  
  
  server <- function(input, output){
    output$data <-renderTable({ 
      infile <-input$file1
      if (is.null(infile))
        return(NULL)
      data <-read.csv(infile$datapath, header = input$header)
      
    })
    output$box <-renderPlot({
      (req(input$file1))
      infile <- input$file1
      data <-read.csv(infile$datapath, header=input$header)
      var <-input$var
      col <-input$cols
      boxplot(data[,var], col=col, main=paste("Selected Variable", var))
    })
  }
  
  # Run the application 
  shinyApp(ui = ui, server = server)
  
}

