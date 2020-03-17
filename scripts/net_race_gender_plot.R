# author: Jimmy Liu and Hannah McSorley
# date: 03-06-2020

doc <- "This script will generate boxplot that describes the relationship between net gain, race and gender from the processed data file as input.

Usage: net_race_gender_plot.R --input=</path/to/input_filename> --output=</path/to/output_filename.png>
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
  print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", opt$output))
  suppressMessages(ggsave(here(opt$output), p))
}

# call main
main(opt$input)