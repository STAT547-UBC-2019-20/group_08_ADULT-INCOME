## Group 08 Team Project

__Adult Income and Personal Attributes__

This repo is for UBC STAT 547 Group project for Group-8, The team members are Jimmy Liu and Hannah McSorley. 
The dataset we're working with is adult income data from the 1994 US Census Bureau available through University California Irvine Machine Learning Repository (https://archive.ics.uci.edu/ml/datasets/adult).

## Milestones and Releases
This repo will evolve with project milestones throughout the course (until April 8, 2020) and each milestone submission will be a tagged release.

### Milestone 1
View the _GitHub Page_ for Milestone 1 here:  https://stat547-ubc-2019-20.github.io/group_08_ADULT-INCOME/docs/milestone01.html

### Milestone 2
Milestone 2 focused on running scripts through command line (or RStudio terminal). 
Below are the instuctions for achieving Milestone 2 goals:

#### Scripts Usage

1. __Clone this repository__

2. __Check the follow R libraries are installed:__
   * tidyverse
   * here
   * glue
   * docopt

3. __Run the scripts under in the following order via command-line__

   a. _Download raw data_ (Task 2.1) 
      ```
      Rscript scripts/load_data.R --data_url="https://github.com/STAT547-UBC-2019-20/data_sets/blob/master/adult_data.csv" --output data/datafile_loaded
      ```
   Note: this will also be achieved by cloning the repo to an RStudio Project through git version control
   
   b. _Process raw data_ (Task 2.2)
      ```
      Rscript scripts/data_processing.R --input data/adult.data --output data/adult.data.processed
      ```
   c. _Visualize processed data_ (Task 2.3)
      * Net gain vs education boxplot
        ```
        Rscript scripts/net_education_plot.R --input data/adult.data.processed --output images/net_education_plot.png
        ```
      * Net gain vs work hours per week boxplot
        ```
        Rscript scripts/net_work_hours_plot.R --input data/adult.data.processed --output images/net_work_hours_plot.png
        ```
