# author: Jimmy Liu and Hannah McSorley
# date: 2020-03-23

"This script is the main file that creates a Dash app.

Usage: app.R
"

# Load libraries
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)


# Create Dash instance
app <- Dash$new()

# 3. Specify App layout
app$layout(
  htmlDiv(
    list(
      htmlH1('1994 ADULT INCOME CENSUS')
    )
  )
)


# 4. Run app

app$run_server(debug=TRUE)

# command to add dash app in Rstudio viewer:
# rstudioapi::viewer("http://127.0.0.1:8050")