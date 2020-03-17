# author: Jimmy Liu and Hannah McSorley

# define phony targets
.PHONY: all clean

# load data
downloaded_datafile : scripts/load_data.R
	Rscript scripts/load_data.R --data_url="https://raw.githubusercontent.com/STAT547-UBC-2019-20/data_sets/master/adult_data.csv" --output data/downloaded_datafile

# process and clean data
processed_DL_datafile : scripts/data_processing.R downloaded_datafile
	Rscript scripts/data_processing.R --input data/downloaded_datafile --output data/processed_DL_datafile

# EDA 1 to plot net gain vs education levels
net_education_plot.png : scripts/net_education_plot.R processed_DL_datafile
	Rscript scripts/net_education_plot.R --input data/processed_DL_datafile --output images/net_education_plot.png

# EDA 2 to plot net gain vs work hours
net_work_hours_plot.png : scripts/net_work_hours_plot.R processed_DL_datafile
	Rscript scripts/net_work_hours_plot.R --input data/processed_DL_datafile --output images/net_work_hours_plot.png

# EDA 3 to plot net gain vs work hours
net_race_gender_plot.png : scripts/net_race_gender_plot.R processed_DL_datafile
	Rscript scripts/net_race_gender_plot.R --input data/processed_DL_datafile --output images/net_race_gender_plot.png

# plot linear regression
linear-regression_plot.png : scripts/linear-regression_plot.R processed_DL_datafile
	Rscript scripts/linear-regression_plot.R --input data/processed_DL_datafile --output images/linear-regression_plot.png

# knit final report
docs/FinalReport_milestone03.pdf docs/FinalReport_milestone03.html : scripts/knit.R net_race_gender_plot.png net_education_plot.png net_work_hours_plot.png linear-regression_plot.png processed_DL_datafile docs/FinalReport_milestone03.Rmd
	Rscript scripts/knit.R --finalreport docs/FinalReport_milestone03.Rmd

# clean temporary files under images/, data/, and docs/
clean :
	rm images/*
	rm data/*
	rm docs/*.html
	rm docs/*.md
	
# all targets
all : docs/FinalReport_milestone03.pdf docs/FinalReport_milestone03.html

