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
                  top_sidebar,
                  htmlDiv(
                    className = "pretty_container",
                    list(
                      htmlH3("Financial Summary"),
                      table
                    ), style = list("height"=260,
                                    "width"="100%")
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
  #update distribution figure
  output=list(id = 'distribution', property='figure'),
  #based on variables selected
  params=list(input(id = 'dropdown', property='value')),
  #this translates your list of params into function arguments
  function(dropdown_value) {
    make_distribution(dropdown_value)
    })
  
# app call back (analytics)  -- I think there's an error here - graph is not interactive.
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

# Run app

app$run_server(debug = TRUE)

# command to add dash app in Rstudio viewer:
# rstudioapi::viewer("http://127.0.0.1:8050")