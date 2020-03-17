The scripts in this folder are intended to be run via command line execution. 

## Scripts Usage

1. __Clone the project repository__

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
   _2: load the data from the dile downloaded in Task 2.1:_
      ```
      Rscript scripts/data_processing.R --input data/downloaded_datafile --output data/processed_DL_datafile
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
