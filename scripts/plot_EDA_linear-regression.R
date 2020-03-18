# author: Jimmy Liu and Hannah McSorley
# date: 2020-03-13

doc <- "This script will generate two scatter plots of worker age versus hours worked per week 
with the intent of displaying a linear section of data.

Usage: EDA_linear-regression.R --input=</path/to/input_filename> --output=</path/to/output_filename.png>
"

# load library
suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(glue))
suppressMessages(library(docopt))
suppressMessages(library(ggpmisc))
suppressMessages(library(cowplot))

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
  print(glue("[",as.character(Sys.time()),"] Plotting data..."))
  # full data set
  p1 <- dat %>% 
    ggplot(aes(x = age, y = hours_per_week))+
    geom_jitter(alpha = 0.4)+
    theme_bw()+
    labs(y = "hrs/wk", x = "")
  
  # generate scatter plot
  print(glue("[",as.character(Sys.time()),"] Plotting linear section of data..."))
  # filtered dataset
  p2 <- dat %>% 
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
  print(glue("[",as.character(Sys.time()),"] Success! Exporting plot image to: ", opt$output))
  suppressMessages(ggsave(here(opt$output), p))
}

# call main
main(opt$input)