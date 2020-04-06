# functions to create plots and tables for Group 8 app.R

# load library
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(plotly))
suppressPackageStartupMessages(library(glue))
suppressPackageStartupMessages(library(ggpubr))
suppressPackageStartupMessages(library(scales))


### interactive slider
## isolates a range of numeric values for analytics plot
# retrieve x-axis slider upper limits, lower limits, and steps
variable_limits_key <- tibble(variable = c("age", "education_num",  "net", "hours_per_week"),
                              upper_limit = c(90, 16, 99999, 99),
                              lower_limit = c(17, 1, -4536, 1),
                              steps = c(1, 1, 1000, 1)
)

get_x_slider_limits <- function(variable_x = "hours_per_week") {
  variable_limits_key %>% 
    filter(variable == variable_x)
}

# retrieve y-axis slider upper limits, lower limits, and steps
get_y_slider_limits <- function(variable_y = "net") {
  variable_limits_key %>% 
    filter(variable == variable_y)
}

# create disabled options in dropdown_x given values in dropdown_y
disable_options_x <- function(variable_y = "net") {
  options <- map(1:nrow(dropdownkey_x), function(i) {
    list(label = dropdownkey_x$label[i], value = dropdownkey_x$value[i])
  })
  n <- which(dropdownkey_x$value == variable_y) # map variable_y to options list position/index
  
  # disable value in options
  options[[n]]["disabled"] <- TRUE
  # return
  options
}

# create disabled options in dropdown_y given values in dropdown_x
disable_options_y <- function(variable_x = "hours_per_week") {
  options <- map(1:nrow(dropdownkey_y), function(i) {
    list(label = dropdownkey_y$label[i], value = dropdownkey_y$value[i])
  })
  n <- which(dropdownkey_y$value == variable_x) # map variable_y to options list position/index
  
  # disable value in options
  options[[n]]["disabled"] <- TRUE
  # return
  options
}

### create distribution plots
make_distribution <- function(variable = "age", scale = "Linear") {
  
  p <- dat %>%
    filter(!!sym(variable) != "?") %>% 
    count(!!sym(variable)) %>%
    ggplot(aes(x = !!sym(variable), y = n, customdata = !!sym(variable))) +
    geom_bar(stat = "identity") +
    labs(
      x = dropdownkey$label[which(dropdownkey$value == variable)],
      y = "Count",
      title = glue("Sampling distribution of ", dropdownkey$label[which(dropdownkey$value == variable)])
    ) +
    theme_bw(14)
  
  if (variable %in% c("native_country", "education", "marital_status")) {
    p <- p + rotate_x_text()
  }
  
  if (scale == "Logarithmic") {
    p <- p + scale_y_log10() +
      labs(y = "Log10(Count)")
  }

ggplotly(p) %>% 
  layout(clickmode = 'event+select')
}

### create summary table
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
                                        "Under $50K income (%)", 
                                        "Over $50K income (%)")
  
  
  summary
}

## make subpopulation text
make_subpopulation <- function(variable = "age", value = "Not Selected") {
  if_else(variable == "education_num", 
          glue("Subpopulation: ", as.character(value), " years"),
          if_else(variable == "age",
                  glue("Subpopulation: ", as.character(value), " years old"),
                  glue("Subpopulation: ", as.character(value)))
  )
}

### create analytics graph 
make_analytics <- function(variable_x = "hours_per_week", variable_y = "net", color_variable = "sex",
                           x_lower_lim=get_x_slider_limits()$lower_limit, x_upper_lim=get_x_slider_limits()$upper_limit,
                           y_lower_lim=get_y_slider_limits()$lower_limit, y_upper_lim=get_y_slider_limits()$upper_limit) {
  p2 <- dat %>% 
    ggplot(aes(x = !!sym(variable_x), y = !!sym(variable_y), color = !!sym(color_variable))) +
    geom_jitter(alpha = 0.6) +  
    labs(
      x = dropdownkey_x$label[which(dropdownkey_x$value == variable_x)],
      y = dropdownkey_y$label[which(dropdownkey_y$value == variable_y)],
      title = glue(dropdownkey_x$label[which(dropdownkey_x$value == variable_x)],
                   " vs. ",
                   dropdownkey_y$label[which(dropdownkey_y$value == variable_y)]),
      color = dropdownkey_color$label[which(dropdownkey_color$value == color_variable)]
    ) +
    theme_bw(14)
  
  if (variable_x == "net") {
    p2 <- p2 + scale_x_continuous(limits = c(x_lower_lim, x_upper_lim),
                                  labels = label_dollar())
  } else {
    p2 <- p2 + scale_x_continuous(limits = c(x_lower_lim, x_upper_lim))
  }
  
  if (variable_y == "net") {
    p2 <- p2 + scale_y_continuous(limits = c(y_lower_lim, y_upper_lim),
                                  labels = label_dollar())
  } else {
    p2 <- p2 + scale_y_continuous(limits = c(y_lower_lim, y_upper_lim)) 
  }

  ggplotly(p2)
}


