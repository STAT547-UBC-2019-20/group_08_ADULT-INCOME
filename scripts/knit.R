# author: Jimmy Liu and Hannah McSorley
# date: 2020-03-14
# Milestone03 Task 2

doc <- "This script knits the final report together.
Usage: script/knit.R --finalreport=<finalreport>" 

# load required package
library(docopt)

# parse arguments
opt <- docopt(doc)

# define main function
main <- function(finalreport) {
  rmarkdown::render(finalreport, 
                    c("html_document", "pdf_document"))
}

# call main
main(opt$finalreport)