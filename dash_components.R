# script to create div components for Group 8 app.R

# title
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

Below, you can _interactively visualize_ the demographics of participants included in the '94 census, and see a financial summary. In the 'Analytics' section, you can compare variables such as education level, age, sex, hours worked, ethnicity or annual net gain.

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
Use the dropdown menus to select variables, and further explore relationships in the data by narrowing the range of numeric data with the slider.
      
Do you notice any interesting patterns in the data? Do you think this data was representative of all 1994 adult income earners?      
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
    label = c("Sex", "Age", "Work Class", "Education", "Marital Status", "Race", "Native Country"),
    value = c("sex", "age", "workclass", "education", "marital_status", "race", "native_country")
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
    label = c("Sex", "Age", "Years of Ed.", "Race", "Net Capital Gain", "Hours Worked per Week"),
    value = c("sex", "age", "education_num",  "race", "net", "hours_per_week")
  )
dropdown_x <- dccDropdown(
  id = "dropdown_x",
  options = map(1:nrow(dropdownkey_x), function(i) {
    list(label = dropdownkey_x$label[i], value = dropdownkey_x$value[i])
  }),
  value = "age" # set default value
)

## dropdown for analytics (y variable)
dropdownkey_y <-
  tibble(
    label = c("Sex", "Age", "Work Class", "Education", "Years of Ed.", "Net Capital Gain", "Hours Worked per Week"),
    value = c("sex", "age", "workclass", "education", "education_num",  "net", "hours_per_week")
  )
dropdown_y <- dccDropdown(
  id = "dropdown_y",
  options = map(1:nrow(dropdownkey_y), function(i) {
    list(label = dropdownkey_y$label[i], value = dropdownkey_y$value[i])
  }),
  value = "hours_per_week" # set default value
)
 

# sidebars
## demographics overview
top_sidebar <- htmlDiv(
      className = "pretty_container",
      list(
        htmlP("Select the distribution plot variable:"),
        dropdown,
        htmlBr()
      ), style = list('columnCount' = 1,
                      'height'=300,
                      'width'='100%',
                      'white-space' = 'pre-line')
)

## analytics sidebar
bottom_sidebar <- htmlDiv(
  className = "pretty_container",
  list(
    htmlP("Select the plot variables:"),
    dropdown_x,
    dropdown_y,
    htmlBr()
    ), style = list('columnCount' = 1,
                    'height'=500,
                    'width'="20.5%",
                    'white-space' = 'pre-line')
)

# plots + tables
## distribution plot (demographics)
distribution <- htmlDiv(dccGraph(id = "distribution",
                         figure = make_distribution()),
                        style = list("display"="block",
                                     "margin-right"='auto',
                                     "margin-left"='auto',
                                     'width'="100%",
                                     "marginTop"=75))


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
                              figure = make_analytics()))

# analytics slider --- this is not dynamic (and also not right)
slider <- dccSlider(
  id = 'slider',
  min = min(dat$net)-144,
  max = max(dat$net)+1,
  marks = list(
    '-4500' = list("label" = '-$4500'),
    '0' = list("label" = '$0'),
    '2500' = list("label" = '$2500'),
    '5000' = list("label" = '$5000'),
    '10000' = list("label" = '$10000')),
  #value = length(unique(dat$net)),
  vertical = FALSE
  )


