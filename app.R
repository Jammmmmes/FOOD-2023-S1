library(sf)
library(leaflet)
library(leaflet.esri)
library(leaflet.extras)
library(mapview)
library(leafpm)
library(shiny)
library(shinycssloaders)
library(rgdal)
library(plotly)
library(htmltools)
library(scales)
library(DT)
library(shinyjs)
library(stringr)
library(tidyverse)
library(symengine)
library(mgcv)
library(mgcViz)
library(gratia)
library(gridExtra)
library(reticulate)
library(shiny)

ui <- fluidPage(
  titlePanel("AgriGAM spatiotemporal trend analysis"),
  
  tabsetPanel(
    type = "tabs",
    id = "tabs",
    
    tabPanel(
      "Area",
      useShinyjs(),
      fluidRow(
        column(
          width = 8,
          leafletOutput("map", height = 600, width = "100%")
        )
      ),
      br(),
      actionButton("calc", "Generate Outputs", class = "btn-primary btn-lg btn-block"),
      br(),
      div(
        class = "alert alert-info",
        "Use the polygon (square or triangle) functions to select an area of interest on the map. Once an area is selected, press the 'Generate Outputs' button above and check out the Crop Mask tab."
      )
    ),
    
    tabPanel(
      "Crop Mask",
      leafletOutput("CMMap", height = 600, width = "100%"),
      br(),
      div(
        class = "alert alert-info",
        "The map above shows a crop mask for the selected area. The NDVI data and analysis will be limited to this crop mask. If this area looks ok, click on the Dashboard tab to check out the outputs. The Dashboard tab may take a few minutes to load."
      )
    ),
    
    tabPanel(
      "Dashboard",
      div(
        class = "container-fluid",
        fluidRow(
          column(
            width = 12,
            h4("Spatiotemporal trends in crop production"),
            p("The plots below illustrate spatiotemporal trends in crop production.")
          )
        ),
        fluidRow(
          column(
            width = 6,
            plotOutput("plot1", height = 500, width = "100%")
          ),
          column(
            width = 6,
            plotOutput("plot2", height = 500, width = "100%")
          )
        ),
        fluidRow(
          column(
            width = 6,
            plotOutput("plot3", height = 500, width = "100%")
          ),
          column(
            width = 6,
            plotOutput("plot4", height = 500, width = "100%")
          )
        ),
        fluidRow(
          column(
            width = 12,
            plotOutput("plot5", height = 500, width = "100%")
          )
        ),
        br(),
        div(
          class = "alert alert-warning",
          "If this Dashboard returns an error, check the Crop Mask tab again to ensure the selected area includes sufficient cropland."
        )
      )
    )
  )
)
# ui <- fluidPage(
#   titlePanel("AgriGAM spatiotemporal trend analysis"),
#   
#   tabsetPanel(
#     type = "tabs",
#     
#     tabPanel(
#       "Area",
#       useShinyjs(),
#       br(),
#       h4("Estimate spatiotemporal trends in crop production"),
#       br(),
#       p("Use the polygon (square or triangle) functions to select an area of interest on the map."),
#       p("Once an area is selected, press the 'Generate Outputs' button below and check out the Crop Mask tab."),
#       br(),
#       fluidRow(
#         column(
#           width = 8,
#           leafletOutput("map", height = 600, width = "100%")
#         )
#       ),
#       actionButton("calc", "Generate Outputs")
#     ),
#     
#     tabPanel(
#       "Crop Mask",
#       br(),
#       h4("Crop mask for the selected area"),
#       p("The map below shows a crop mask for the selected area. The NDVI data and analysis will be limited to this crop mask."),
#       p("If this area looks ok, click on the Dashboard tab to check out the outputs. The Dashboard tab may take a few minutes to load."),
#       br(),
#       leafletOutput("CMMap", height = 600, width = "100%")
#     ),
#     
#     tabPanel(
#       "Dashboard",
#       br(),
#       h4("Spatiotemporal trends in crop production"),
#       p("The plots below illustrate spatiotemporal trends in crop production."),
#       p("The top-left plot shows the partial main effect of year on cropland NDVI, while the top-right shows the partial main effect of month, indicating phenology."),
#       p("The middle-left plot shows the partial main effect of space, and the middle-right shows the interaction between month and year, indicating changes in seasonality."),
#       p("The next plot shows the variance in NDVI attributable to each effect. Finally, scrolling down reveals the space x year interaction plot which shows interannual changes in space."),
#       p("If this Dashboard returns an error, check the Crop Mask tab again to ensure the selected area includes sufficient cropland."),
#       br(),
#       shinycssloaders::withSpinner(
#         plotOutput("plot", height = 1400, width = "100%")
#       )
#     )
#   )
# )



# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
