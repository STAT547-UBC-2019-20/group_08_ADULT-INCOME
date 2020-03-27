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
      x = variable,
      y = "Count",
      title = glue("Distribution of ", variable)
    ) +
    theme_bw()

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

# create empty graph
make_empty <- function() {
  p <- dat %>% 
    ggplot(aes(x = sex, y = age))
  ggplotly(p)
}