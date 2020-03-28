# load library
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(plotly))
suppressPackageStartupMessages(library(glue))
suppressPackageStartupMessages(library(ggpubr))

# create distribution plots
make_distribution <- function(variable = "sex", scale = "Linear") {
  
  p <- dat %>%
    filter(!!sym(variable) != "?") %>% 
    count(!!sym(variable)) %>%
    ggplot(aes(x = !!sym(variable), y = n, customdata = !!sym(variable))) +
    geom_bar(stat = "identity") +
    labs(
      x = dropdownkey$label[which(dropdownkey$value == variable)],
      y = "Count",
      title = glue("Distribution of ", dropdownkey$label[which(dropdownkey$value == variable)])
    ) +
    theme_bw(14)
  
  if (variable %in% c("native_country", "education")) {
    p <- p + rotate_x_text()
  }
  
  if (scale == "Logarithmic") {
    p <- p + scale_y_log10() +
      labs(y = "Log10(Count)")
  }

ggplotly(p) %>% 
  layout(clickmode = 'event+select')
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
  
  summary <- data.frame(
    Minimum = min,
    Median = median,
    Maximum = max,
    `Less than 50k` = `<=50k`,
    `More than 50k` = `>50k`
  ) %>%
    gather(key = "Statistics", value = "Value") 
  
  # convert less/more than 50K to proportions
  summary$Value[c(4:5)] <- round(summary$Value[c(4:5)]/(summary$Value[4]+summary$Value[5])*100, 2)
    
  # rename the statistics
  summary$Statistics[c(1,2,3,4,5)] <- c("Minimum net gain ($)",
                                        "Median net gain ($)",
                                        "Maximum net gain ($)",
                                        "<=50K net gain (%)", 
                                        ">50K net gain (%)")
  
  
  summary
}

# create empty graph
make_empty <- function() {
  p <- dat %>% 
    ggplot(aes(x = sex, y = age))
  ggplotly(p)
}

# make subpopulation text
make_subpopulation <- function(variable = "sex", value = "Not Selected") {
  if (variable == "age") {
    glue("Subpopulation: ", as.character(value), " years old")
  } else {
    glue("Subpopulation: ", as.character(value))
  }
}