# author: Jimmy Liu and Hannah McSorley

# define phony targets
.PHONY: all clean

# load data
downloaded_datafile : scripts/load_data.R
	Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile

# process and clean data
processed_adult-data.csv : scripts/data_processing.R downloaded_datafile
	Rscript scripts/data_processing.R --input data/downloaded_datafile --output data/processed_adult-data.csv

# EDA 1 to plot net gain vs education levels
plot_net-education.png : scripts/plot_net-education.R processed_adult-data.csv
	Rscript scripts/plot_net-education.R --input data/processed_adult-data.csv --output images/plot_net-education.png

# EDA 2 to plot net gain vs work hours
plot_net-work-hours.png : scripts/plot_net-work-hours.R processed_adult-data.csv
	Rscript scripts/plot_net-work-hours.R --input data/processed_adult-data.csv --output images/plot_net-work-hours.png

# EDA 3 to plot net gain vs race and sex hours
plot_net-race-gender.png : scripts/plot_net-race-gender.R processed_adult-data.csv
	Rscript scripts/plot_net-race-gender.R --input data/processed_adult-data.csv --output images/plot_net-race-gender.png

# EDA 4 to identify and plot a linear section of data
plot_EDA_linear-regression.png : scripts/plot_EDA_linear-regression.R processed_adult-data.csv
	Rscript scripts/plot_EDA_linear-regression.R --input data/processed_adult-data.csv --output images/plot_EDA_linear-regression.png

# plot linear regression
plot_linear-regression.png : scripts/plot_linear-regression.R processed_adult-data.csv
	Rscript scripts/plot_linear-regression.R --input data/processed_adult-data.csv --output images/plot_linear-regression.png

# generate and save linear regression model
lm_age-hrs.RDS : scripts/linear_regression.R processed_adult-data.csv
	Rscript scripts/linear_regression.R --input data/processed_adult-data.csv --output data/lm_age-hrs.RDS

# knit final report
docs/FinalReport_milestone03.html docs/FinalReport_milestone03.pdf : scripts/knit.R plot_net-race-gender.png plot_net-education.png plot_net-work-hours.png plot_EDA_linear-regression.png plot_linear-regression.png lm_age-hrs.RDS processed_adult-data.csv docs/FinalReport_milestone03.Rmd
	Rscript scripts/knit.R --finalreport docs/FinalReport_milestone03.Rmd

# clean temporary files under images/, data/, and docs/
clean :
	rm images/*
	rm data/*
	rm docs/*.html
	rm docs/*.md
	
# all targets
all : docs/FinalReport_milestone03.pdf docs/FinalReport_milestone03.html

