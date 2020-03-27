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

# dropdown
dropdownkey <-
  tibble(
    label = c("Sex", "Age", "Work Class", "Education", "Martial Status", "Race", "Native Country"),
    value = c("sex", "age", "workclass", "education", "martial_status", "race", "native_country")
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

# sidebars
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

bottom_sidebar <- htmlDiv(
  className = "pretty_container",
  list(
    htmlP("Select the plot variable:"),
    place_holder,
    htmlBr()
    ), style = list('columnCount' = 1,
                    'height'=500,
                    'width'="20.5%",
                    'white-space' = 'pre-line')
)

# distribution plot
distribution <- dccGraph(id = "distribution",
                         figure = make_distribution())

# empty plot
empty <- dccGraph(id = "empty",
                         figure = make_empty())

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
