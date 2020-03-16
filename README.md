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

2. __Check the follow R libraries are installed:__
   * tidyverse
   * here
   * glue
   * docopt

3. __Run the scripts under in the following order via command-line__

   a. __Download raw data__ 
   _Note: a copy of the datafile will also be available by cloning the repo to an RStudio Project through git version control_
      ```
      Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile
      ```
   b. __Process raw data__
   _load and process the data from the previously downloaded file_
      ```
      Rscript scripts/data_processing.R --input data/downloaded_datafile --output data/processed_adult-data.csv
      ```

   c. __Visualize processed data__
      * Net gain vs education boxplot
        ```
        Rscript scripts/net_education_plot.R --input data/processed_adult-data.csv --output images/net_education_plot.png
        ```
      * Net gain vs work hours per week boxplot
        ```
        Rscript scripts/net_work_hours_plot.R --input data/processed_adult-data.csv --output images/net_work_hours_plot.png
        ```
   d. __Generate a linear model__
   _this uses a subset of data to create a linear model_
      ```
      Rscript scripts/linear_regression.R --input data/processed_adult-data.csv --output data/lm_age-hrs.RDS
      ```
      * Data visualization
         ```
        Rscript scripts/linear-regression_plot.R --input data/processed_adult-data.csv --output images/linear-regression_plot.png
        ```
   
   e. __Produce a complete final report__
   _knit a report via RMD file
