# author: Jimmy Liu and Hannah McSorley
# date: 2020-03-13

doc <- "This script will generate a scatter plot of worker age (under 30) 
versus hours worked per week with linear regression line.

Usage: linear-regression_plot.R --input=</path/to/input_filename> --output=</path/to/output_filename.png>
"

# load library
suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(glue))
suppressMessages(library(docopt))
suppressMessages(library(ggpmisc))

# parse arguments
opt <- docopt(doc)

# define main
main <- function(input_path) {
  
  # read input file
  print(glue("[",as.character(Sys.time()),"] Reading input file from: ", opt$input))
  dat <- suppressMessages(
    read_csv(here(input_path), col_names = TRUE)
  )
  
  # generate scatter plot
  print(glue("[",as.character(Sys.time()),"] Linear model data visualization:"))
  print(glue("[",as.character(Sys.time()),"] Generating plot..."))
  p <- dat %>% 
    filter(age < 30,
           hours_per_week != 40, hours_per_week >= 10) %>% 
    ggplot(aes(x = age, y = hours_per_week))+
    geom_jitter()+
    geom_smooth(method = lm)+
    labs(y = "work hours per week", x = "age of worker",
         title = "hours worked per week for workers under 30 yrs of age")+
    ggpmisc::stat_poly_eq(formula = y ~ x, 
                 aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
                 parse = TRUE, rr.digits = 4)
  
  # export plot as png
  print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", opt$output))
  suppressMessages(ggsave(here(opt$output), p))
}

# call main
main(opt$input)