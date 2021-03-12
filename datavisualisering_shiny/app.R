#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(tidyverse)
library(readxl)

passat <- read_excel("passat.xlsx")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Det her er titlen på min app", title = div(img(src = "pepsi.png"))),

    theme = shinytheme("cosmo"),
    
    headerPanel("Her er en titel"),
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel("Her er min sidebar",
                     selectInput("xaxis", label = "Vælg x-akse", choices = names(passat), selected = "km_per_liter", TRUE, multiple = F), 
                     selectInput("yaxis", label ="y-akse", choices = names(passat), multiple = F),
                     helpText("Goddag mand økseskaft")
                     ),

        # Show a plot of the generated distribution
        mainPanel("Her kommer indhold",
          tabsetPanel(
              id = "tabs",
              tabPanel("Plot", plotOutput("plot")), 
              tabPanel("Tabel", tableOutput("tabel"))
              
          )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$plot <- renderPlot({
        ggplot(
            data = passat, aes_string(
                x = (as.name(input$xaxis)), 
                y = (as.name(input$yaxis))
                )
             ) + geom_point()
    })
   
}

# Run the application 
shinyApp(ui = ui, server = server)
