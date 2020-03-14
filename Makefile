# author: Jimmy Liu and Hannah McSorley

# load data
downloaded_datafile : scripts/load_data.R
	Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile

# process and clean data
processed_DL_datafile : scripts/data_processing2.R downloaded_datafile
	Rscript scripts/data_processing2.R --input data/downloaded_datafile --output data/processed_DL_datafile

# EDA 1 to plot net gain vs education levels
net_education_plot.png : scripts/net_education_plot.R processed_DL_datafile
	Rscript scripts/net_education_plot.R --input data/processed_DL_datafile --output images/net_education_plot.png

# EDA 2 to plot net gain vs work hours
net_work_hours_plot.png : scripts/net_work_hours_plot.R processed_DL_datafile
	Rscript scripts/net_work_hours_plot.R --input data/processed_DL_datafile --output images/net_work_hours_plot.png

# linear regression

# knit report

# clean temporary files under images/, data/, and docs/
clean :
	rm images/*
	rm data/*
	rm docs/*.html
	rm docs/*.md
	
# define phony variable: all to run the entire analysis
all : net_education_plot.png net_work_hours_plot.png

