# author: Jimmy Liu and Hannah McSorley
# date: 2020-03-13
# Milestone03 Task 1

doc <- "This script will perform linear regression on a subset of the filtered adult income dataset

Usage: data_processing.R --input=</path/to/input_filename> --output=</path/to/output_filename>
"

# load library
suppressMessages(library(docopt))
suppressMessages(library(here))
suppressMessages(library(tidyverse))
suppressMessages(library(glue))

# parse arguments
opt <- docopt(doc)

# define main
main <- function(input_path) {
  
  # read (filtered and processed) input file
  print(glue("[",as.character(Sys.time()),"] Reading input file from: ", opt$input))
  dat <- suppressMessages(
    read_csv(here(input_path), col_names = TRUE)
  )
  
  # provide process message
  print(glue("[",as.character(Sys.time()),"] Filter for linear section of data:
             'under age of 30, over 10 hrs/week of work and not equal to 40 hrs/week'
             .
             .
             .
             Generating linear model (age ~ hours/week)..."))
  
  # filter data for a linear relationship 
  # age (under 30) & hours worked per week (>10, not 40)
  df <- dat %>% 
    filter(age < 30,
           hours_per_week != 40, hours_per_week >= 10) 

  # generate linear model
  lmfit <- lm(age ~ hours_per_week, df)
  
  # provide process message
  print(glue("[",as.character(Sys.time()),"] Linear model created."))
  
  # save linear model as an RDS file
  print(glue("[",as.character(Sys.time()),"] Saving model as RDS file: ", opt$output))
  saveRDS(lmfit, file = here(opt$output))
  
}

# call main
main(opt$input)
