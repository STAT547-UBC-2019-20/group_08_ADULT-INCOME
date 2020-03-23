# author: Jimmy Liu and Hannah McSorley
# date: 03-06-2020
# updated 2020-03-13

doc <- "This script will perform preliminary processing and filtering of 
adult income dataset (downloaded_datafile) and 

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
  
  # provide read file message
  print(glue("[",as.character(Sys.time()), "] Reading input file from: ", opt$input))
  
  # check if file exists
  print(glue("[",as.character(Sys.time()), "] Validating path to file..."))
  
  if (file.exists(opt$input) == T) {
    print(glue("[",as.character(Sys.time()), "] Success validation!")) 
  } else {
    stop(glue(opt$input, " does not exist"), call. = F) # stop script execution
  }
  
  # read input file
  dat <- suppressMessages(
    read_csv(here(input_path), col_names = c("age", "workclass", "fnlwgt", "education", "education_num", "martial_status", 
                                                  "occupation", "relationship", "race", "sex", "capital_gain", "capital_loss", 
                                                  "hours_per_week", "native_country", "label"))
  )
  
  # remove rows that contain zeroes for both capital gain and loss and merge capital-gain and capital-loss into a single variable, net
  dat.filt <- dat %>% 
    dplyr::filter(capital_gain != capital_loss) %>% 
    dplyr::mutate(net = if_else(capital_gain == 0, 
                                as.numeric(capital_loss)*-1, # transform capital-loss to negative values 
                                as.numeric(capital_gain)),
                  race = factor(trimws(race)))  # remove leading white spaces, convert to factor
  
  # write out processed dataframe as csv
  print(glue("[",as.character(Sys.time()),"] Finished processing file..."))
  print(glue("[",as.character(Sys.time()),"] Writing output to: ", opt$output))
  readr::write_csv(dat.filt, path = here(opt$output),col_names = TRUE)
}

# call main
main(opt$input)
