#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Question 1 Done

library(shiny)

   ui <-  fluidPage( 
          numericInput(inputId = "samples", "Sample size:", min = 1, max = 100, value = 30),
          sliderInput(inputId = "mu", "Choose Mean :", min = 0, max = 100, value = 20, step = 1),
          sliderInput(inputId = "signma", "Choose Standard Deviation :", min = 0, max = 100, value = 40, step = 1),
          plotOutput(outputId = "hist")
          )
   server <- 
     function(input, output) { 
       output$hist <- renderPlot({ 
         hist(rnorm(input$samples, input$mu, input$signma))
       }) 
     }
   
   shinyApp(ui = ui, server = server)

