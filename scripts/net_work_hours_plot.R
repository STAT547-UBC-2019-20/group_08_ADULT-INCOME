# author: Jimmy Liu and Hannah McSorley
# date: 03-06-2020

doc <- "This script will generate boxplot that describes the relationship between work hours per week and annual net gain from the processed data file as input.

Usage: net_work_hours_plot.R --input=</path/to/input_filename> --output=</path/to/output_filename.png>
" 

# load library
suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(glue))
suppressMessages(library(docopt))

# parse arguements
opt <- docopt(doc)

# define main
main <- function(input_path) {
  # read input file
  print(glue("[",as.character(Sys.time()),"] Reading input file from: ", opt$input))
  dat <- suppressMessages(
    read_csv(here(input_path), col_names = TRUE)
  )
  
  # generate boxplot
  print(glue("[",as.character(Sys.time()),"] Generating plot..."))
  p <- dat %>% 
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
  print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", opt$output))
  suppressMessages(ggsave(here(opt$output), p))
}

# call main
main(opt$input)