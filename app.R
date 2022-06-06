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
my_theme <- bs_theme(
    #defining background here messes with the slider widget's coloring
    #bg = "rgba(21, 42, 54)", 
    primary = "rgba(138, 220, 221)",
    secondary = "#000000",
    base_font = font_google("Montserrat", wght = "400"),
    heading_font = font_google("Montserrat Alternates", wght = "600")
  )

# Create user interface
ui <- fluidPage(
  
  #background color must be defined outside of bs_theme to avoid 
  #issue with slider input coloring
  tags$head(tags$style(HTML('body {
                             background-color: rgba(21, 42, 54);
              }'))),
  
  title = "Percolation Simulation",
  
  theme = my_theme,
  
  fluidRow(
    column(11,
           
      style = "background-color: rgba(245, 245, 245);
               border-radius: 50px;
               position: absolute;
               top: 50%;
               left: 50%;
               transform: translate(-50%, -50%);",
      
      fluidRow(
          column(2,
                 
            style = "background-color: rgba(255, 255, 255);
                     border-radius: 30px;
                     padding: 20px;
                     margin: 20px;
                     box-shadow: 10px 10px 25px rgba(0, 0, 0, 0.10);",
            
            tags$style("#dim {background-color: rgba(138, 220, 221);
                       border-radius: 10px;
                       border-width: 0px;}"),
            
            numericInput("dim", label = h4("Dimension", style = "margin-top: 10px; color: rgba(21, 42, 54)"),
                         min = 5, max = 1000, value = 100),
            
            tags$style("#prob {
                       .irs-bar,
                       .irs-bar-edge,
                       .irs-single,
                       .irs-grid-pol {
                         background: red;
                         border-color: red;
                       }
                       }"),
            
            sliderInput("prob", label = h4("Site occupation probability", style = "color: rgba(21, 42, 54);"),
                        min = 0, max = 1, value = 0.6),
            br(),
            br(),
            br(),
            br(),
            br(),
            br(),
            br(),
            
            #github link
            tags$a(
              href="https://github.com/Jakob-Lovato/percolation-app", 
              tags$img(src="github_logo.png",
                       height = "30"),
              tags$text("View project on Github",
                        style = "font-size: 13px;")
            )
          ),
          
          column(4,
            
            style = "background-color: rgba(255, 255, 255);
                     border-radius: 30px;
                     padding: 20px;
                     margin-top: 20px;
                     margin-right: 20px;
                     margin-bottom: 20px;
                     box-shadow: 10px 10px 25px rgba(0, 0, 0, 0.10);",
            
            h2("Percolation Simulation", style = "margin-top: 0px; color: rgba(21, 42, 54);"),
            
            p("Percolation theory describes the behavior of a system of interconnected nodes.
              A system “percolates” if there is some cluster of occupied nodes (or sites)
              that is able to reach from one boundary in a system to another boundary."),
            
            p("In the panel to the left, select the dimension of the plot you want to generate,
              and the site occupation probability. This is the probability that each pixel (or
              site) on the grid will be occupied. Occupied sites are shown in grey, non-occupied
              sites are white, and if the system has a percolating cluser, it will be highlighted
              in light blue."),
            
            p("Note: Percolation typically first occurs with a site occupation probability of about 0.59. 
              Suggested probabilities are between 0.59 and 0.7")
          ),
          column(5,
                 
                 style = "margin: auto;",
                 
                 plotOutput("plot")
        )
      )
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