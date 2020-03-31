# script to create div components for Group 8 app.R

# title bar
title <- htmlDiv(
  className = "pretty_container",
  list(htmlH1('1994 ADULT INCOME CENSUS')),
  style = list(
    'columnCount' = 1,
    'background-color' = 'lightblue',
    'text-align' = 'center',
    'height'=75
    )
)

# app overview
introduction <- htmlDiv(
  className = "pretty_container",
  list(
    htmlH2("Introduction"),
    dccMarkdown(
      "
Welcome to the dashboard developed by UBC STAT 547 Group 8!

This app allows folks to explore data from the 1994 Adult Income Census.

Below, you can _interactively visualize_ the demographics of participants included in the '94 census and see a financial summary based on groups of the population. 
In the 'Analytics' section, you can compare variables such as education level, age, sex, hours worked, ethnicity or annual net gain.

      "
    ))
)

# app instructions
instructions <- htmlDiv(
  className = "pretty_container",
  list(
    htmlH2("Instructions"),
    dccMarkdown(
      "
1. Demographics Overview:

_Visualize the distribution of available data_
  * choose between 7 different demographic variables in the dropdown menu to explore the sampling distribution
  * toggle between linear and logarithmic scales of distribution counts 
  * fill in the financial summary table by clicking on a bar in the distribution plot 
    * clicking a bar selects a particular subpopulation (e.g. all males or a particular age); default is N/A
    * income stats for that subpopulation will show in the table 
    
2. Analytics:

_Explore relationships in the 1994 Adult Income Census data_
  * select variables from the dropdown menus to plot variables on the _x_ and _y_ axes
  * choose a variable in the _'colour by'_ menu to use for colour-coding data on the plot
  * use the sliders to isolate the range of data plotted on each axes
   
Do you notice any interesting patterns in the data? 

Do you think this data was representative of all 1994 adult income earners?      
      "
    ))
)

# Headers
## demographics header
demographics_header <- htmlDiv(
  className = "pretty_container",
  list(htmlH2("Demographics Overview")),
  style = list('background-color'='',
               'height'=30
               )
)

## analytics header
analytics_header <- htmlDiv(
  className = "pretty_container",
  list(htmlH2("Analytics")),
  style = list('background-color'='',
               'height'=30,
               'vertical-align'='middle')
)


# Dropdowns
## dropdown for distribution
dropdownkey <-
  tibble(
    label = c("Sex", "Age", "Work Class", "Years of Ed.", "Marital Status", "Race", "Native Country"),
    value = c("sex", "age", "workclass", "education_num", "marital_status", "race", "native_country")
  )
dropdown <- dccDropdown(
  id = "dropdown",
  options = map(1:nrow(dropdownkey), function(i) {
    list(label = dropdownkey$label[i], value = dropdownkey$value[i])
  }),
  value = "age" # set default value
)


## dropdown for analytics (x variable)
dropdownkey_x <-
  tibble(
    label = c("Age", "Years of Ed.","Net Capital Gain", "Hours Worked per Week"),
    value = c("age", "education_num",  "net", "hours_per_week")
  )
dropdown_x <- dccDropdown(
  id = "dropdown_x",
  options = map(1:nrow(dropdownkey_x), function(i) {
    list(label = dropdownkey_x$label[i], value = dropdownkey_x$value[i])
  }),
  value = "hours_per_week" # set default value
)

## dropdown for analytics (y variable)
dropdownkey_y <-
  tibble(
    label = c("Age", "Years of Ed.","Net Capital Gain", "Hours Worked per Week"),
    value = c("age", "education_num",  "net", "hours_per_week")
  )
dropdown_y <- dccDropdown(
  id = "dropdown_y",
  options = map(1:nrow(dropdownkey_y), function(i) {
    list(label = dropdownkey_y$label[i], value = dropdownkey_y$value[i])
  }),
  value = "net" # set default value
)

## style - dropdown for analytics (y variable)
dropdownkey_color <-
  tibble(
    label = c("Race", "Sex", "Marital Status"),
    value = c("race", "sex", "marital_status")
  )
dropdown_color <- dccDropdown(
  id = "dropdown_color",
  options = map(1:nrow(dropdownkey_color), function(i) {
    list(label = dropdownkey_color$label[i], value = dropdownkey_color$value[i])
  }),
  value = "sex" # set default value
)

# Radio Buttons (Demographics)
## distribution_scale
distribution_scale <- dccRadioItems(id = "log",
                        options = list(
                          list(label = "Linear", value = "Linear"),
                          list(label = "Logarithmic", value = "Logarithmic")
                        ),
                        value = "Linear")

# slider (analytics)
## x-axis
slider_x <- dccRangeSlider(
  id='slider_x',
  min=get_x_slider_limits()$lower_limit,
  max=get_x_slider_limits()$upper_limit,
  step=get_x_slider_limits()$steps,
  value=list(get_x_slider_limits()$lower_limit+2, get_x_slider_limits()$upper_limit-2)
)

## y-axis
slider_y <- dccRangeSlider(
  id='slider_y',
  min=get_y_slider_limits()$lower_limit,
  max=get_y_slider_limits()$upper_limit,
  step=get_y_slider_limits()$steps,
  value=list(get_y_slider_limits()$lower_limit+2000, get_y_slider_limits()$upper_limit-2000)
)


# sidebars
## demographics overview
top_sidebar <- htmlDiv(
      className = "pretty_container",
      list(
        htmlP("Select the distribution plot variable:"),
        dropdown,
        htmlBr(),
        htmlP("Select the scale of y-axis:"),
        distribution_scale
      ), style = list('columnCount' = 1,
                      'height'=290,  # was 290
                      'width'='100%',
                      'white-space' = 'pre-line')
)

## analytics sidebar
bottom_sidebar <- htmlDiv(
  className = "pretty_container",
  list(
    htmlP("Select the plot variables:"),
    htmlLabel("x-axis"),
    dropdown_x,
    htmlBr(),
    htmlLabel("y-axis"),
    dropdown_y,
    htmlBr(),
    htmlLabel("Colour by"),
    dropdown_color,
    htmlP("Adjust x-axis range:"),
    slider_x,
    htmlDiv(id='select_slider_x'),
    htmlP("Adjust y-axis range:"),
    slider_y,
    htmlDiv(id='select_slider_y')
    ), style = list('columnCount' = 1,
                    'height'=500,
                    'width'="20.5%",
                    'white-space' = 'pre-line')
)

# subpopulation header
subpopulation <- htmlP(make_subpopulation(),
                       id = 'subpopulation')

# plots + tables
## distribution plot (demographics)
distribution <- htmlDiv(dccGraph(id = "distribution",
                        figure = make_distribution()),
                        style = list("display"="block",
                                     "margin-right"='auto',
                                     "margin-left"='auto',
                                     'width'="100%",
                                     "marginTop"=125))

## summary table (demographics)
table <- dashDataTable(
  id = "table",
  columns = lapply(colnames(make_table()), 
                   function(colName){
                     list(
                       id = colName,
                       name = colName
                     )
                   }),
  data = df_to_list(make_table()),
  style_table = list('height'='auto')
)

## analytics plot
analytics <- htmlDiv(dccGraph(id = "analytics",
                              figure = make_analytics()),
                     style = list("display"="block",
                                  "margin-right"='auto',
                                  "margin-left"='auto',
                                  'width'="100%",
                                  'marginTop'=25))

# end of dash app components
