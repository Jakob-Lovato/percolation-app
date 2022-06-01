### This shiny app creates visualizations of percolation processes
### Jakob Lovato, 2022

library(shiny)
library(ggplot2)
library(reshape2)
library(raster)
library(igraph)
library(bslib)
library(shinythemes)
library(showtext)
library(sysfonts)

# helpers.R contains functions used to create/plot percolation systems in 2D
# modified from Spring 2022 Stat 753 final project code
source("helpers.R")

# Create custom theme for app
light_theme <- bs_add_variables(
  bs_theme(
    bg = "#F7F7F7",
    fg = "#000000",
    primary = "#5067e8",
    secondary = "#000000",
    base_font = font_google("Varela"),
    heading_font = font_google("Varela Round")
  ),
  "badge-border-radius" = "0.5em"
)

# Make plot background obey theme
shinyOptions(plot.autocolors = TRUE)

# Create user interface
ui <- fluidPage(
  #tags$image(src = "Lovato_Jakob_Ex_1.jpg",
  #           style = "position: absolute"),
  theme = light_theme,
  
  titlePanel("Percolation Simulation"),
  
  sidebarLayout(
    sidebarPanel(
      # Using CSS to modify sidebar panel appearance
      tags$style(".well {background-color: rgba(255, 255, 255, 0.5);
                 border-radius: 20px;
                 border-width: 0px;
                 box-shadow: 10px 10px 25px rgba(0, 0, 0, 0.10);
                 }"),
      
      helpText("Select the dimension of the percolation system and the probability of site occupation below"),
      
      numericInput("dim", label = h3("Dimension"), min = 5, max = 1000, value = 100),
      
      sliderInput("prob", label = h3("Site occupation probability"), min = 0, max = 1, value = 0.59)
    ),
    
    mainPanel(
      helpText("Percolation theory describes the behavior of a system of interconnected nodes."),
      helpText("A system “percolates” if there is some cluster that is able to reach from one 
               boundary in a system to another boundary."),
      
      plotOutput("plot")
    )
  )
)

# Server Logic
server <- function(input, output){
  
  output$plot <- renderPlot({
    grid <- createGrid(input$dim, input$prob)
    plotPerc(grid)
  }, bg = "transparent")
}

# Run App
shinyApp(ui, server)