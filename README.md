## Group 08 Team Project

__Adult Income and Personal Attributes__

This repo is for UBC STAT 547 Group project for Group-8, The team members are Jimmy Liu and Hannah McSorley. 
The dataset we're working with is adult income data from the 1994 US Census Bureau available through University California Irvine Machine Learning Repository (https://archive.ics.uci.edu/ml/datasets/adult).

## Milestones and Releases
This repo will evolve with project milestones throughout the course (until April 8, 2020) and each milestone submission will be a tagged release.

### Milestone 1
View the _GitHub Page_ for Milestone 1 here:  https://stat547-ubc-2019-20.github.io/group_08_ADULT-INCOME/docs/milestone01.html

### Milestone 2
Milestone 2 focused on running scripts through command line (or RStudio terminal). Below are the instuctions for use:

#### Scripts Usage

1. __Clone this repository__

2. __Check that you have the follow R packages installed:__
   * tidyverse
   * here
   * glue
   * docopt
   * ggpmisc
   * cowplot

3. __Run the scripts under in the following order via command-line__

   a. __Download raw data__ 
   
   _Note: a copy of the datafile will also be available by cloning the repo to an RStudio Project through git version control_
      ```
      Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile.csv
      ```
   b. __Process raw data__
   
   _load and process the data from the previously downloaded file_
      ```
      Rscript scripts/data_processing.R --input data/downloaded_datafile.csv --output data/processed_adult-data.csv
      ```

   c. __Visualize processed data__
   
   _generate four different exploratory analysis plots from the processed data_
      ```
      Rscript scripts/EDA_plots.R --input data/processed_adult-data.csv
      ```
        
### Milestone 3

4. To generate a linear model on filtered data, and create a plot, run the following script:

   a. __Linear model__
      * Generate .RDS file containing linear model object
      ```
      Rscript scripts/linear_regression.R --input data/processed_adult-data.csv --output data/lm_age-hrs.RDS
      ```
      * Linear regression data visualization
      ```
      Rscript scripts/plot_linear-regression.R --input data/processed_adult-data.csv --output images/plot_linear-regression.png
      ```
   
   b. __Produce a complete final report__ _knit a report via R markdown file_
      ```
      Rscript scripts/knit.R --finalreport docs/FinalReport_milestone03.Rmd
      ```

5. Run the entire analysis pipeline using `make` after cloning the repository

   In the terminal, type `make all` to produce final report, and view it here:
   
      * [docs/FinalReport_milestone03.html](https://stat547-ubc-2019-20.github.io/group_08_ADULT-INCOME/docs/FinalReport_milestone03.html)
   
   _Note, to remove temporary files produced by the pipeline, run `make clean` in the terminal_
