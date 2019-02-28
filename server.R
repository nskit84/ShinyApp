#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(UsingR)
library(caret)
library(randomForest)

#Server function
shinyServer(function(input, output) {
  
  #Linear Regression model
  model1 <- lm(price ~ carat, data =  diamond)
  
  #Random Forest model
  model2 <- train(price ~ ., method = "rf", data = diamond )
  
  #Predict function for linear regression model based on user input 
  model1Pred <- reactive({
    slidInput <- input$slide1
     predict(model1, newdata = data.frame(carat = slidInput))
    
  })
  
  #Prdict function for random forest model based on user input
  model2Pred <- reactive({
    slidInput <- input$slide1
    predict(model2, newdata = data.frame(carat = slidInput))
    
  })
  
  #Plot the predicted value and dataset value.
   output$modelPlot <- renderPlot({
     
     slidInput <- input$slide1
     
     plot(diamond$carat, diamond$price, xlab = "Diamond Carat",
          ylab = "Diamond Price", bty = "n", pch = 16)
     
     if(input$showModel1){ 
       abline(model1, col = "red", lwd =2)
       
     }
     
     if(input$showModel2){
      x <- seq(0.11,0.35, by=0.002)
      model2lines <- predict(model2, newdata = data.frame(carat = x))
      lines(x, model2lines , col = "blue", lwd =4)
      ## abline(c(), col = "blue", lwd = 3)
     }
     
     legend(2, 5, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
            col = c("red", "blue"), bty = "n", cex = 1.2)
     points(slidInput, model1Pred(), col = "red", pch =16, cex = 2)
     points(slidInput, model2Pred(), col = "blue", pch = 16, cex = 2)
   })
   
   #output model1 predicted value
   output$textM1 <- renderText({
     model1Pred()
   })
   
   #output model2 predicted value
   output$textM2 <- renderText({
     model2Pred()
   })
 
})
