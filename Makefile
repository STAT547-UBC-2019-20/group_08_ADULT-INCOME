# author: Jimmy Liu and Hannah McSorley

# define phony targets
.PHONY: all clean

# load data
downloaded_datafile.csv : scripts/load_data.R
	Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile.csv

# process and clean data
processed_adult-data.csv : scripts/data_processing.R downloaded_datafile.csv
	Rscript scripts/data_processing.R --input data/downloaded_datafile.csv --output data/processed_adult-data.csv

# Construct EDA plots
EDA_plots : scripts/EDA_plots.R processed_adult-data.csv
	Rscript scripts/EDA_plots.R --input data/processed_adult-data.csv

# plot linear regression
plot_linear-regression.png : scripts/plot_linear-regression.R processed_adult-data.csv
	Rscript scripts/plot_linear-regression.R --input data/processed_adult-data.csv --output images/plot_linear-regression.png

# generate and save linear regression model
lm_age-hrs.RDS : scripts/linear_regression.R processed_adult-data.csv
	Rscript scripts/linear_regression.R --input data/processed_adult-data.csv --output data/lm_age-hrs.RDS

# knit final report
docs/final_report.html : scripts/knit.R EDA_plots plot_linear-regression.png lm_age-hrs.RDS processed_adult-data.csv docs/FinalReport_milestone03.Rmd
	Rscript scripts/knit.R --finalreport docs/FinalReport_milestone03.Rmd

# clean temporary files under images/, data/, and docs/
clean :
	rm images/*
	rm data/*
	rm docs/*.html
	rm docs/*.md
	
# all targets
all : docs/final_report.html

