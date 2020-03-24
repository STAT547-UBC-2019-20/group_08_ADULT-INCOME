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
   
      ```
      Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile.csv
      ```
   _Note: a copy of the datafile will also be available by cloning the repo to an RStudio Project through git version control_
      
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

4. To generate a linear model on filtered data, create a plot, and knit a final report - run the following scripts:

   a. __Linear model__
      * Generate .RDS file containing linear model object
      ```
      Rscript scripts/linear_regression.R --input data/processed_adult-data.csv --output data/lm_age-hrs.RDS
      ```
      * Linear regression data visualization
      ```
      Rscript scripts/plot_linear-regression.R --input data/processed_adult-data.csv --output images/plot_linear-regression.png
      ```
   
   b. __Produce a complete final report__ 
      ```
      Rscript scripts/knit.R --finalreport docs/FinalReport_milestone03.Rmd
      ```
   _the above command knits a report via R markdown file_

5. Run the entire analysis pipeline using `make` after cloning the repository

   In the terminal, type `make all` to produce final report. View the product here:
   
      * [docs/FinalReport_milestone03.html](https://stat547-ubc-2019-20.github.io/group_08_ADULT-INCOME/docs/FinalReport_milestone03.html)
   
   _Note, to remove files produced by the pipeline, run `make clean` in the terminal._
   _Only run 'make clean' if you are certain it is necessary (we discourage running this command)._
   
### Milestone 4 (Task 2): Dashboard Proposal

__Description__

Our app will have a landing page that presents both a summary of the (1994 adult income census) data demographics as well as bi-variate data comparisons. The 'summary' section will provide an overview of the dataset where the user can choose (from a dropdown menu) which key variable to summarize in a plot and a table of min/med/max net gain. In addition to the dropdown menu, there will be a radio-button/radiometer option to toggle between options for the selected key variable (e.g., male vs female, under or over \$50K income). The 'analysis' portion of the app will show the distribution of each person's education, age, sex, ethnicity as they relate to each other and to annual net gain (monetary gains over employment income). These plots will likely be a combination of boxplots, violin plots and/or density ridge plots. Users will be able to compare variables by toggling between different explanatory variables to visualize their relationship to net income and/or to eachother. From a drop-down list, users will be able to select different demographic variables to visualize the metadata distribution of the census participants (i.e. only show females, or specific ethnicities). Via a slider bar, users will be able to narrow the range of data displayed based on filterable variables (e.g., age, education level, average hours worked per week). This app will allow users to compare two variables such as education level, age, sex, hours worked, ethnicity or annual net gain, and also to rank personal attributes relative to whether annual income is predicted to be above or below $50,000.

__Sketch of dashboard plan__

<img src = "https://github.com/HJMcSorley/group_08_ADULT-INCOME-1/blob/master/images/dashboard-sketch.jpg" height="75%" width="75%">


__Usage Scenario__

Pat is interested in understanding how personal attributes and socioeconomic position are associated with annual financial gains. They want to [explore] a census dataset to [compare] attributes (e.g., age, sex, marital status, education and work hours) with annual net gain amounts to [identify] patterns relating monetary benefits to personal and socioeconomic details. When Pat logs on to the “1994 Adult Income Census Data App”, they will see an overview of all the available variables in the dataset, according to the number of instances (persons) associated with each demographic category. They can filter variables to narrow the range of personal attributes to compare to net annual gains, and/or rank census participants according to their predicted annual income (over or under $50K). When Pat does so, they may notice that there are no apparent links between the available personal attributes and net annual gain. They may also notice that the data is dominated by a specific demographic, which may encourage them to pursue the collection of more representative and diverse demographic data in future census.
   
