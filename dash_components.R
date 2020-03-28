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

# app instructions
instructions <- htmlDiv(
  className = "pretty_container",
  list(
    htmlH2("Instructions"),
    dccMarkdown(
"
Welcome to the dashboard developed by Group 8!
        
Blah..Blah..Blah,
Blah..Blah..Blah
"
              ))
)

# demographics header
demographics_header <- htmlDiv(
  className = "pretty_container",
  list(htmlH2("Demographics Overview")),
  style = list('background-color'='',
               'height'=30
               )
)

# analytics header
analytics_header <- htmlDiv(
  className = "pretty_container",
  list(htmlH2("Analytics")),
  style = list('background-color'='',
               'height'=30,
               'vertical-align'='middle')
)

# dropdown for distribution
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
  value = "sex" # set default value
)

place_holder <- dccDropdown(
  id = "place_holder",
  options = map(1:nrow(dropdownkey), function(i) {
    list(label = dropdownkey$label[i], value = dropdownkey$value[i])
  }),
  value = "sex" # set default value
)

# --- H
# dropdown for analytics (x)
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

place_holder_x <- dccDropdown(
  id = "place_holder_x",
  options = map(1:nrow(dropdownkey_x), function(i) {
    list(label = dropdownkey_x$label[i], value = dropdownkey_x$value[i])
  }),
  value = "age" # set default value
)

# dropdown for analytics (y)
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

place_holder_y <- dccDropdown(
  id = "place_holder_y",
  options = map(1:nrow(dropdownkey_y), function(i) {
    list(label = dropdownkey_y$label[i], value = dropdownkey_y$value[i])
  }),
  value = "hours_per_week" # set default value
)
# --- 

# sidebars
# demographics overview
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

# analytics
bottom_sidebar <- htmlDiv(
  className = "pretty_container",
  list(
    htmlP("Select the plot variables:"),
    place_holder_x,
    place_holder_y,
    htmlBr()
    ), style = list('columnCount' = 1,
                    'height'=500,
                    'width'="20.5%",
                    'white-space' = 'pre-line')
)

# distribution plot
distribution <- htmlDiv(dccGraph(id = "distribution",
                         figure = make_distribution()),
                        style = list("display"="block",
                                     "margin-right"='auto',
                                     "margin-left"='auto',
                                     'width'="100%",
                                     "marginTop"=75))


# summary table
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

# analytics plot
analytics <- htmlDiv(dccGraph(id = "analytics",
                              figure = make_analytics()))
