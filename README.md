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

   a. __Download raw data__ (Task 2.1) 
      ```
      Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile
      ```
   _Note: a copy of the datafile will also be available by cloning the repo to an RStudio Project through git version control_
   
   b. __Process raw data__ (Task 2.2)
   There are two options to process the data:
   
   _1: load the data from a local file:_
      ```
      Rscript scripts/data_processing.R --input data/adult.data --output data/adult.data.processed
      ```
   _2: load the data from the file downloaded in Task 2.1:_
      ```
      Rscript scripts/data_processing2.R --input data/downloaded_datafile --output data/processed_DL_datafile
      ```
   These two commands generate equivalent output files, from different sources. 
   
   c. __Visualize processed data__ (Task 2.3)
      * Net gain vs education boxplot
        ```
        Rscript scripts/net_education_plot.R --input data/adult.data.processed --output images/net_education_plot.png
        ```
      * Net gain vs work hours per week boxplot
        ```
        Rscript scripts/net_work_hours_plot.R --input data/adult.data.processed --output images/net_work_hours_plot.png
        ```
   _note that each of the above scripts can be run with 'processed_DL_datafile' as input to generate the same plots._      
