# functions to create plots and tables for Group 8 app.R

# load library
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(plotly))
suppressPackageStartupMessages(library(glue))

# create distribution plots
make_distribution <- function(variable = "sex") {
  p <- dat %>%
    filter(!!sym(variable) != "?") %>% 
    count(!!sym(variable)) %>%
    ggplot(aes(x = !!sym(variable), y = n)) +
    geom_bar(stat = "identity") +
    labs(
      x = dropdownkey$label[which(dropdownkey$value == variable)],
      y = "Count",
      title = glue("Distribution of ", dropdownkey$label[which(dropdownkey$value == variable)])
    ) +
    theme_bw(14)

ggplotly(p)
}

# create summary table
make_table <- function(variable = "sex", value = "Male") {
  filter <- dat %>%
    filter(!!sym(variable) == value) %>%
    select(net, label)
  min <- min(filter$net)
  median <- median(filter$net)
  max <- max(filter$net)
  `<=50k` <- length(which(filter$label == "<=50K"))
  `>50k` <- length(which(filter$label == ">50K"))
  
  summary <- tibble(
    min = min,
    median = median,
    max = max,
    `<=50k` = `<=50k`,
    `>50k` = `>50k`
  ) %>%
    gather(key = "stat", value = "value")
  
  summary
}

# create analytics graph 
make_analytics <- function(variable_x = "age", variable_y = "hours_per_week") {
  p2 <- dat %>%
    filter(!!sym(variable_x) != "?",
           !!sym(variable_y) != "?") %>% 
    ggplot(aes(x = !!sym(variable_x), y = !!sym(variable_y))) +
    geom_jitter(alpha = 0.6) +  
    labs(
      x = dropdownkey_x$label[which(dropdownkey_x$value == variable_x)],
      y = dropdownkey_y$label[which(dropdownkey_y$value == variable_y)],
      title = glue(dropdownkey_x$label[which(dropdownkey_x$value == variable_x)],
                   " vs. ",
                   dropdownkey_y$label[which(dropdownkey_y$value == variable_y)])
    ) +
    theme_bw(14)
  
  ggplotly(p2)
}

# create an interactive slider
# isolates a range of numeric values for analytics plot -- not operational yet
make_slider <- function(variable_x = "age") {
  slider <- dat %>% 
    filter(!!sym(variable_x) != "?")  
    
}

# create radio buttons
# to select binary identifiers