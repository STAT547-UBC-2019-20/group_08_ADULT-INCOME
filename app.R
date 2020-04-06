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
                            htmlLabel("Click on a bar from the plot to select a subpopulation for its financial summary"),
                            subpopulation,
                            table
                        ), style = list("height"=370,
                                        "width"="100%")
                      )
                    ), style = list("width"="20%",
                                    "height"="100%")),
                  htmlDiv( # top component graph
                    className = "pretty_container",
                    distribution,
                    style = list("width"="80%",
                                 "height"=740,
                                 'margin-left'=60)
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
              htmlDiv( # bottom component plot
                className = "pretty_container",
                analytics,  # plot
                style = list('width'='80%',
                             'height' = 500,
                             'align-items' = 'left')
              )
            ), style = list('display'='flex',
                            'width'='100%'),  
          )
        ), style = list('width'='100%',
                        'height'='50%') 
      )
    ), style = list('display' = 'block',
                    'margin-left' = 'auto',
                    'margin-right' = 'auto',
                    'width'='79.5%',
                    'height'='80%')
  )
)

# callbacks:

# demographics dropdown
app$callback(
  output=list(id = 'distribution', property='figure'),
  params=list(input(id = 'dropdown', property='value'),
              input(id = 'log', property='value')),
  function(dropdown_value, scale_value) {
    make_distribution(dropdown_value, scale_value)
  })
  
# analytics dropdown  
app$callback(
  # update analytics figure
  output=list(id = 'analytics', property='figure'),
  #based on variables selected 
  params=list(input(id = 'dropdown_x', property='value'),
              input(id = 'dropdown_y', property='value'),
              input(id = 'dropdown_color', property='value'),
              input(id = 'slider_x', property='value'),
              input(id = 'slider_y', property='value')),
  #this translates your list of params into function arguments
  function(x_selection, y_selection, color_selection, x_slider_lim, y_slider_lim) {
    make_analytics(x_selection, y_selection, color_selection,
                   as.numeric(x_slider_lim[1]), as.numeric(x_slider_lim[2]), as.numeric(y_slider_lim[1]), as.numeric(y_slider_lim[2]))
  })

# disable options in dropdown_y
app$callback(
  # update available dropdown options in dropdown_y given dropdown_x
  output=list(id = 'dropdown_y', property="options"),
  params=list(input(id = 'dropdown_x', property="value")),
  function(x_value) {
    disable_options_y(x_value)
  }
)

# disable options in dropdown_x
app$callback(
  # update available dropdown options in dropdown_x given dropdown_y
  output=list(id = 'dropdown_x', property="options"),
  params=list(input(id = 'dropdown_y', property="value")),
  function(y_value) {
    disable_options_x(y_value)
  }
)

# financial summary table (demographics)
app$callback(output = list(id = 'table', property = 'data'),
						 params = list(input(id='dropdown', property='value'),
						               input(id='distribution', property='clickData')),
						 function(dropdown_value, clickData) {
						 	make_table(dropdown_value, value = dat[[dropdown_value]][which(dat[[dropdown_value]] == clickData$points[[1]]$customdata)[1]])
						 	})

# sub-population click data (demographics)
app$callback(output = list(id = 'subpopulation', property = 'children'),
             params = list(input(id='dropdown', property='value'),
                           input(id='distribution', property='clickData')),
             function(dropdown_value, clickData) {
               make_subpopulation(dropdown_value, value = dat[[dropdown_value]][which(dat[[dropdown_value]] == clickData$points[[1]]$customdata)[1]])
             })

# analytics slider:

# x-axis slider
app$callback(
  output(id = 'select_slider_x', property='children'),
  params=list(input(id='slider_x', property='value')),
  function(value) {
    sprintf('You have selected [%0.1f, %0.1f]', value[1], value[2])
  })

# y-axis slider 
app$callback(
  output(id = 'select_slider_y', property='children'),
  params=list(input(id='slider_y', property='value')),
  function(value) {
    sprintf('You have selected [%1.0f, %1.0f]', value[1], value[2])
  })

# x-axis slider link to dropdown (bounds)
app$callback(
  output(id = 'slider_x', property = 'value'),
  params=list(input(id='dropdown_x', property='value')),
  function(value) {
    list(get_x_slider_limits(value)$lower_limit, get_x_slider_limits(value)$upper_limit)
  })

# x-axis slider link to dropdown (min)
app$callback(
  output(id = 'slider_x', property = 'min'),
  params=list(input(id='dropdown_x', property='value')),
  function(value) {
    get_x_slider_limits(value)$lower_limit
  })

# x-axis slider link to dropdown (max)
app$callback(
  output(id = 'slider_x', property = 'max'),
  params=list(input(id='dropdown_x', property='value')),
  function(value) {
    get_x_slider_limits(value)$upper_limit
  })

# x-axis slider link to dropdown (steps)
app$callback(
  output(id = 'slider_x', property = 'step'),
  params=list(input(id='dropdown_x', property='value')),
  function(value) {
    get_x_slider_limits(value)$steps
  })

# y-axis slider link to dropdown (bounds)
app$callback(
  output(id = 'slider_y', property = 'value'),
  params=list(input(id='dropdown_y', property='value')),
  function(value) {
    list(get_y_slider_limits(value)$lower_limit, get_y_slider_limits(value)$upper_limit)
  })

# y-axis slider link to dropdown (min)
app$callback(
  output(id = 'slider_y', property = 'min'),
  params=list(input(id='dropdown_y', property='value')),
  function(value) {
    get_y_slider_limits(value)$lower_limit
  })

# y-axis slider link to dropdown (max)
app$callback(
  output(id = 'slider_y', property = 'max'),
  params=list(input(id='dropdown_y', property='value')),
  function(value) {
    get_y_slider_limits(value)$upper_limit
  })

# y-axis slider link to dropdown (steps)
app$callback(
  output(id = 'slider_y', property = 'step'),
  params=list(input(id='dropdown_y', property='value')),
  function(value) {
    get_y_slider_limits(value)$steps
  })

# Run app
app$run_server(debug = TRUE)

# command to add dash app in Rstudio viewer:
# rstudioapi::viewer("http://127.0.0.1:8050")