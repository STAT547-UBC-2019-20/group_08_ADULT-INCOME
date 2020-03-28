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
        
1. Demographics Overview:
  * choose between 7 different demographic variables to explore the sampling distribution
  * distribution counts can be toggled between linear or logarithmic scale
  * click on one of the bars in the distribution plot to understand the financial summary of a particular subpopulation (e.g. all males in the census), default is N/A

2. Analytics:
  * 

_By Jimmy Liu and Hannah McSorley 2020_
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

# distribution_scale
distribution_scale <- dccRadioItems(id = "log",
                        options = list(
                          list(label = "Linear", value = "Linear"),
                          list(label = "Logarithmic", value = "Logarithmic")
                        ),
                        value = "Linear")
# sidebars
top_sidebar <- htmlDiv(
      className = "pretty_container",
      list(
        htmlP("Select the distribution plot variable:"),
        dropdown,
        htmlBr(),
        htmlP("Select the scale of y-axis:"),
        distribution_scale
      ), style = list('columnCount' = 1,
                      'height'=290,
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

# subpopulation header
subpopulation <- htmlP(make_subpopulation(),
                       id = 'subpopulation')

# distribution plot
distribution <- htmlDiv(dccGraph(id = "distribution",
                        figure = make_distribution()),
                        style = list("display"="block",
                                     "margin-right"='auto',
                                     "margin-left"='auto',
                                     'width'="100%",
                                     "marginTop"=75))

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
