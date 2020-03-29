# author: Jimmy Liu and Hannah McSorley
# date: 2020-03-23

"This script is the main file that creates a Dash app for Group 8, Adult Income.

Usage: app.R
"

# Load libraries
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
suppressPackageStartupMessages(library(here))

# load data
dat <- read.csv(here("data/processed_adult-data.csv"), header = T)

# source
source(here("dash_functions.R"))
source(here("dash_components.R"))

# Create Dash instance
app <- Dash$new()

# Specify App layout
app$layout(
  title,
  introduction,
  instructions,
  htmlDiv( # content board
    list(
      htmlDiv( # top component
        list(
          demographics_header,
          htmlDiv( # top component contents
            list(
              htmlDiv( # top component sidebar + table
                list(
                  htmlDiv( # top component side
                    list(
                      top_sidebar,
                      htmlDiv(
                        className = "pretty_container",
                        list(
                          htmlH3("Financial Summary"),
                          subpopulation,
                          table
                        ), style = list("height"=280,
                                        "width"="100%")
                      )
                    ), style = list("width"="20%",
                                    "height"="100%")),
                  htmlDiv( # top component graph
                    className = "pretty_container",
                    distribution,
                    style = list("width"="80%",
                                 "height"=610,
                                 'margin-left'=50)
                  )
                ), style = list("width"="20%",
                                "height"="100%")),
              htmlDiv( # top component graph
                className = "pretty_container",
                distribution,
                style = list("width"="80%",
                             "height"=600,
                             'margin-left'=50)
              )
            ), style = list('display'= 'flex',
                            'height'="100%")
          )
        ), style = list('height'="50%") 
      ),
      # bottom components
      htmlDiv( 
        list(
          analytics_header,
          htmlDiv( # bottom component contents
            list(
              bottom_sidebar, # sidebar
              
              # bottom component plot
              htmlDiv( 
                className = "pretty_container",
                analytics,  # plot
                style = list('width'='80%',
                             'height' = '95%',
                             'align-items' = 'left')  # plot style
              ),
              htmlDiv( # adding slider -----------------------------------------------
                slider,
                style = list('width'='80%',
                             'height' = '5%',
                             'align-items' = 'left')  # slider style 
              ) # slider try -----------------------------------------------
            ), style = list('display'='flex',
                            'width'='100%'),  # sidebar style
            
          )
        ), style = list('width'='100%',
                        'height'='50%') # styling lower half of app
      )
    ), style = list('display' = 'block',
                    'margin-left' = 'auto',
                    'margin-right' = 'auto',
                    'width'='79.5%',
                    'height'='80%')
  ) 
)

# app call back (demographics)
app$callback(
  output=list(id = 'distribution', property='figure'),
  params=list(input(id = 'dropdown', property='value'),
              input(id = 'log', property='value')),
  function(dropdown_value, scale_value) {
    make_distribution(dropdown_value, scale_value)
  })
  
# app call back -- analytics dropdown  
app$callback(
  # update analytics figure
  output=list(id = 'analytics', property='figure'),
  #based on variables selected 
  params=list(input(id = 'dropdown_x', property='value'),
              input(id = 'dropdown_y', property='value')),
  #this translates your list of params into function arguments
  function(x_selection, y_selection) {
    make_analytics(x_selection, y_selection)
  })

# app call back -- analytics slider ---- not operational 
app$callback(
  # update analytics figure
  output=list(id = 'analytics', property='figure'),
  #based on variables selected 
  params=list(input(id = 'slider', property='value')),
  #this translates your list of params into function arguments
  function(selection) {
    make_slider(selection)
  })

app$callback(output = list(id = 'table', property = 'data'),
						 params = list(input(id='dropdown', property='value'),
						               input(id='distribution', property='clickData')),
						 function(dropdown_value, clickData) {
						 	make_table(dropdown_value, value = dat[[dropdown_value]][which(dat[[dropdown_value]] == clickData$points[[1]]$customdata)[1]])
						 	})

app$callback(output = list(id = 'subpopulation', property = 'children'),
             params = list(input(id='dropdown', property='value'),
                           input(id='distribution', property='clickData')),
             function(dropdown_value, clickData) {
               make_subpopulation(dropdown_value, value = dat[[dropdown_value]][which(dat[[dropdown_value]] == clickData$points[[1]]$customdata)[1]])
             })

# Run app

app$run_server(debug = TRUE)

# command to add dash app in Rstudio viewer:
# rstudioapi::viewer("http://127.0.0.1:8050")