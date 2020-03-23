# author: Jimmy Liu and Hannah McSorley
# date: 03-06-2020

doc <- "This script will generate four different exploratory analysis plots from process data as input:
1) plot_net-race-gender.png: describes the relationship between net gain, race and gender
2) plot_net-work-hours.png: describes the relationship between work hours per week and annual net gain
3) plot_net-education.png: describes the distribution of annual net gain across education levels 
4) plot_EDA-linear-regression.png: shows the linear fit of age against work hours

Usage: EDA_plots.R --input=</path/to/input_filename>
" 

# load library
suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(glue))
suppressMessages(library(docopt))
suppressMessages(library(ggpmisc))
suppressMessages(library(cowplot))

# parse arguements
opt <- docopt(doc)


# define work hour plot function
work_hours <- function(df) {
  
  # generate boxplot
  print(glue("[",as.character(Sys.time()),"] Generating net-work-hours-plot..."))
  p <- df %>% 
    mutate(work.hours = factor(case_when(`hours_per_week` <= 25 ~ "Short", # define a new variable to bin work hours per week into 4 categories
                                         `hours_per_week` > 25 & `hours_per_week` <= 50 ~ "Medium",
                                         `hours_per_week` > 50 & `hours_per_week` <= 75 ~ "Long",
                                         TRUE ~ "Very Long"),
                               levels = c("Short", "Medium", "Long", "Very Long"))) %>% 
    ggplot(aes(x = work.hours, y = net)) +
    geom_boxplot() +
    theme_bw(12) +
    guides(fill = F) +
    scale_y_continuous(labels = scales::dollar_format()) +
    labs(x = "Work Hours",
         y = "Annual net gain",
         title = "Relationship between work hours per week and annual net gain")
  
  # export plot as png
  print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", "images/plot_net-work-hours.png"))
  suppressMessages(ggsave(here("images/plot_net-work-hours.png"), p))
}


# define education plot function
education <- function(df) {
    
    # generate boxplot
    print(glue("[",as.character(Sys.time()),"] Generating net-education-plot..."))
    p <- df %>% 
      ggplot(aes(x = education, y = net)) +
      geom_boxplot() +
      coord_flip() +
      scale_y_continuous(labels = scales::dollar_format()) +
      theme_bw(12) +
      labs(x = "Education attainment level",
           y = "Annual net gain",
           title = "Relationship between education attainment and annual net gain")
    
    # export plot as png
    print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", "images/plot_net-education.png"))
    suppressMessages(ggsave(here("images/plot_net-education.png"), p))
}


# define race gender plot function
race_gender <- function(df) {
  
  # generate boxplot
  print(glue("[",as.character(Sys.time()),"] Generating net-race-gender-plot..."))
  p <- df %>% 
    ggplot(aes(x = race,
               y = net, fill = sex)) +
    geom_violin() +
    coord_flip() +
    scale_y_continuous(labels = scales::dollar_format()) +
    theme_bw(12) +
    labs(x = "Ethnicity",
         y = "Annual net gain",
         title = "Relationship between race, sex, and annual net gain")
  
  
  # export plot as png
  print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", "images/plot_net-race-gender.png"))
  suppressMessages(ggsave(here("images/plot_net-race-gender.png"), p))
}


# define linear data plot
linear <- function(df) {
  
  # generate scatter plot
  print(glue("[",as.character(Sys.time()),"] Plotting age against work hours..."))
  # full data set
  p1 <- df %>% 
    ggplot(aes(x = age, y = hours_per_week)) +
    geom_jitter(alpha = 0.4)+
    theme_bw()+
    labs(y = "hrs/wk", x = "")
  
  # generate scatter plot
  print(glue("[",as.character(Sys.time()),"] Plotting linear section of data..."))
  # filtered dataset
  p2 <- df %>% 
    filter(age < 30,
           hours_per_week != 40, hours_per_week >= 10) %>% 
    ggplot(aes(x = age, y = hours_per_week))+
    geom_jitter(alpha = 0.4)+
    geom_smooth(method = lm)+
    labs(y = "hrs/wk", x = "age of worker")+
    ggpmisc::stat_poly_eq(formula = y ~ x, 
                          aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
                          parse = TRUE, rr.digits = 3)+
    theme_bw()
  
  # arrange plots
  print(glue("[",as.character(Sys.time()),"] Arranging plots together"))
  # stack plots
  p <- cowplot::plot_grid(p1, p2, align = "v", nrow = 2,
                          labels = c("A", "B"))
  
  # export plot as png
  print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", "images/plot_EDA-linear-regression.png"))
  suppressMessages(ggsave(here("images/plot_EDA-linear-regression.png"), p))
}


# define read input file function
read_file <- function(input_path) {
  
  # print reading file message
  print(glue("[",as.character(Sys.time()),"] Reading input file from: ", opt$input))
  
  # check if file exists
  print(glue("[",as.character(Sys.time()), "] Validating path to file..."))
  
  if (file.exists(opt$input) == T) {
    print(glue("[",as.character(Sys.time()), "] Success validation!")) 
  } else {
    stop(glue(opt$input, " does not exist"), call. = F) # stop script execution
  }
  
  # read file from path
  suppressMessages(read_csv(here(input_path), col_names = TRUE))
  
}


# define main
main <- function(input_path) {
  dat <- read_file(input_path)
  work_hours(dat)
  race_gender(dat)
  education(dat)
  linear(dat)
}


# call main
main(opt$input)