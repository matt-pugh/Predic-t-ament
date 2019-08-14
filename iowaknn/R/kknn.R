# install.packages("kknn")
# install.packages("shiny")
#install.packages("RMySQL")
#install.packages("dbConnect)
library(kknn)
library(shiny)
library(RMySQL)
#(dbConnect)

setwd("C:/Users/Admin/Desktop/Predic(t)ament Project")

ui <- fluidPage(
  titlePanel("Iowa Property Valuation"),
  sidebarLayout(
  sidebarPanel(
    sliderInput(inputId = "OverallQual", label = "Overall Quality and Finish of Property out of 10", min = 0, value = 0, step = 1, max = 10),
    numericInput(inputId = "TotalBsmtSF", label = "Total Basement Area in Square Feet", value = 0, min = 0, step= 1),
    numericInput(inputId = "GrLivArea", label = "Above Grade Ground Floor Living Area in square feet", value = 0, min = 0, step = 1),
    numericInput(inputId = "GarageCars", label = "Number of Cars that Fit in Garage", value = 0, min = 0, step = 1),
    numericInput(inputId = "TotRmsAbvGrd", label = "Total Number of Rooms (excluding bathrooms)", value = 0, min = 0, step = 1)

    ),

  mainPanel(
    textOutput(outputId = "prediction")
    )
  )
)

mydb<- dbConnect(RMySQL::MySQL(), user='root', password='root', dbname='iowahouses')
data<- dbSendQuery(mydb, "SELECT GrLivArea, GarageCars, TotRmsAbvGrd, OverallQual, TotalBsmtSF, SalePrice FROM newtable")
data<- dbFetch(data, n = -1)
dbDisconnect(mydb)

train_subset <- data[,c("GrLivArea", "GarageCars", "TotRmsAbvGrd", "OverallQual", "TotalBsmtSF", "SalePrice")]
training_data <- data[1:950,]


#' Return Prediction of Sale Price
#'
#' This fucntion creates a predicted sale price using variables input through a UI.
#' It does this by creating a KKNN predictive model from a data set imported from a connected SQL database.
#' @param input
#' Input taken from a shiny user interface
#'
#' @return A predicted value of sales price
#' @examples
#' kknn(input)
#' @export
kknn_func<- function(input){
  k_value <- floor(sqrt(nrow(training_data)))
  model <- train.kknn(formula = SalePrice~., data=training_data, kmax=k_value, kernel = "optimal")
  user_input <- data.frame(input$OverallQual,
                           input$TotalBsmtSF,
                           input$GrLivArea,
                           input$GarageCars,
                           input$TotRmsAbvGrd)
  names(user_input) <- c("OverallQual", "TotalBsmtSF",  "GrLivArea", "GarageCars", "TotRmsAbvGrd")
  prediction<- predict(model, user_input)
  return (round(prediction, digits = -2))
}

#' Takes Input from the User Interface and Return a Value for the User
#'
#' This fucntion takes some input from a user interface built in shiny and returns a value for the user.
#' This value is calculated user a separate function called inside this function.
#' @param input
#' Input taken from a shiny user interface
#' @param output
#' Variable to be displayed to the user in the UI
#'
#' @return A value to user interface
#' @examples
#' server(input, output)
#' @export
server <- function(input, output) {

output$prediction <- renderText({
    paste("Predicted Value of £", kknn_func(input))
  })


}

shinyApp(ui = ui, server = server)
