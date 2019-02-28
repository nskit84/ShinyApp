#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Diamond price from carat"),
  
  # Sidebar with a slider input for number of carat
  sidebarLayout(
    sidebarPanel(
       sliderInput("slide1",
                   "What carat diamod you need",
                   min = 0.11,
                   max = 0.35,
                   value = 0.10),
       checkboxInput("showModel1", "Show/Hide Model 1", value = FALSE),
       checkboxInput("showModel2", "Show/Hide Model 2", value = FALSE), 
       
       h3("How to use the application"),
       
      h4(" This application predicts the price of a diamond given the carat value for the diamond."),

      h4(" Two model used for the price predication."),
       
      h4(" - First model: Linear Regression"),
      h4(" - second model: Random Forest"),
       
      h4(" If user selected Carat value in the slidebar. The two model predict value show in the plot and label.")
       
      
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("modelPlot"),
       h3("Predicated Model1 Diamond Price:"),
       textOutput("textM1"),
       h3("Predicated Model2 Diamond Price:"),
       textOutput("textM2")
       )
  )
))
