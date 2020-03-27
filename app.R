# author: Jimmy Liu and Hannah McSorley
# date: 2020-03-23

"This script is the main file that creates a Dash app.

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
      instructions,
      htmlDiv( # content board
        list(
          htmlDiv( # top component
            list(
              demographics_header,
              htmlDiv( # top component contents
                list(
                  htmlDiv( # top component side
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
          htmlDiv( # bottom component
            list(
              analytics_header,
              htmlDiv( # bottom component contents
                list(
                  bottom_sidebar,
                  htmlDiv( # bottom component plots
                        className = "pretty_container",
                        list(empty), 
                        style = list('width'='80%')
                        )
                    ), style = list('display'='flex',
                                    'width'='100%',
                                    'height'="100%")
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

# app call back
app$callback(
  #update figure of box_scatter_plot
  output=list(id = 'distribution', property='figure'),
  #based on values of cut quality
  params=list(input(id = 'dropdown', property='value')),
  #this translates your list of params into function arguments
  function(dropdown_value) {
    make_distribution(dropdown_value)
  })

# Run app

app$run_server(debug = TRUE)

# command to add dash app in Rstudio viewer:
# rstudioapi::viewer("http://127.0.0.1:8050")