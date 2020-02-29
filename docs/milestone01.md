---
title: "Adult Income Study: Milestone 01"
author: "Jimmy Liu and Hannah McSorley"
date: "29/02/2020"
output:
  html_document:
    keep_md: true
---

# Adult Income Study




## Introduction 

The economic well-being of individuals is reliant on their income, where income is defined as the money an individual (or household) receives on a regular basis. In the United States, the Census Bureau uses income  (money received before expenses and deductions) to gauge the population's range of poverty, wealth, and financial security (United States Census Bureau, 2016). There are a variety of factors that can influence one's income, including socioeconomic drivers, education and vocation. This project examines some of the variables that are often related to income. 

## Description of Dataset

This project works with a dataset of adult incomes obtained from the University of California Irvine (UCI) [Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/adult). The data was donated by Ronny Kohavi and Barry Becker (Silicon Graphics) and was originally extracted by Barry Becker from the 1994 Census database and used for machine learning predictions of whether a person makes over $50,000 per year based on personal factors.

This 1994 income census dataset consists of multivariate categorical and integer data that describe socioeconomic and personal classifiers of adults across the USA. Each instance (32,561) is an individual whose annual income was grouped as either above or below $50,000. Table 1 shows an overview of the 15 attributes (variables), including whether each is categorical or integer and a brief interpretation of the variable.  

<br>

```
## Parsed with column specification:
## cols(
##   Variable = col_character(),
##   Type = col_character(),
##   Description = col_character()
## )
```

<!--html_preserve--><div id="htmlwidget-884488ee30b98821a938" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-884488ee30b98821a938">{"x":{"filter":"none","caption":"<caption>description of adult income dataset variables<\/caption>","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"],["age","workclass","fnlwgt","education","education-num","marital-status","occupation","relationship","race","sex","capital-gain","capital-loss","hours-per-week","native-country","label"],["continuous","categorical","continuous","categorical","continuous","categorical","categorical","categorical","categorical","categorical","continuous","continuous","continuous","categorical","categorical"],["age, range from 17 to 90 (mean 38.58)","Private, Self-emp-not-inc, Self-emp-inc, Federal-gov, Local-gov, State-gov, Without-pay, Never-worked.","\"final weight\" - demographic weight by US state controlled by three sets of characteristics including race/age/sex, hispanic origin, and proportion of state population over 16 years of age","Bachelors, Some-college, 11th, HS-grad, Prof-school, Assoc-acdm, Assoc-voc, 9th, 7th-8th, 12th, Masters, 1st-4th, 10th, Doctorate, 5th-6th, Preschool.","years of education. Range from 1 to 16 (mean 10.08)","Married-civ-spouse, Divorced, Never-married, Separated, Widowed, Married-spouse-absent, Married-AF-spouse.","Tech-support, Craft-repair, Other-service, Sales, Exec-managerial, Prof-specialty, Handlers-cleaners, Machine-op-inspct, Adm-clerical, Farming-fishing, Transport-moving, Priv-house-serv, Protective-serv, Armed-Forces.","Wife, Own-child, Husband, Not-in-family, Other-relative, Unmarried.","White, Asian-Pac-Islander, Amer-Indian-Eskimo, Other, Black.","Female, Male","range from 0 to 99999 (mean 1078). Assuming this is annual financial gains in $USD.","range from 0 to 4356 (mean 87.3). Assuming this is annual financial losses in $USD.","average hours worked per week. Range from 1 to 99 (mean 40.44)","United-States, Cambodia, England, Puerto-Rico, Canada, Germany, Outlying-US(Guam-USVI-etc), India, Japan, Greece, South, China, Cuba, Iran, Honduras, Philippines, Italy, Poland, Jamaica, Vietnam, Mexico, Portugal, Ireland, France, Dominican-Republic, Laos, Ecuador, Taiwan, Haiti, Columbia, Hungary, Guatemala, Nicaragua, Scotland, Thailand, Yugoslavia, El-Salvador, Trinadad&amp;Tobago, Peru, Hong, Holand-Netherlands.","annual income above or below threshold of $50000: &gt;50K or &lt;=50K"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Variable<\/th>\n      <th>Type<\/th>\n      <th>Description<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<br>

A couple of assumptions were made about these data based on information on the Census website. It is assumed that "capital gains" indicate non-cash financial benefits (e.g., food stamps, health benefits, subsidized housing or transportation, employer contributions to retirement programs, medical and educational expenses, etc.), and that "capital losses" include non-cash expenses (such as depreciated value of assets). We are also assuming that "education number" indicates the number of years allotted to education.  

It is of note that these data are from 1994 census, and the income threshold of $50,000 held a different meaning for wealth than it holds today. As this dataset includes socioeconomic attributes, it's worth noting that US-born white males comprise the majority of the data instances. 

## Exploratory Data Analysis 

### Summary overview


```
##       age                    workclass         fnlwgt       
##  Min.   :17.00    Private         :22696   Min.   :  12285  
##  1st Qu.:28.00    Self-emp-not-inc: 2541   1st Qu.: 117827  
##  Median :37.00    Local-gov       : 2093   Median : 178356  
##  Mean   :38.58    ?               : 1836   Mean   : 189778  
##  3rd Qu.:48.00    State-gov       : 1298   3rd Qu.: 237051  
##  Max.   :90.00    Self-emp-inc    : 1116   Max.   :1484705  
##                  (Other)          :  981                    
##          education     education-num                  martial_status 
##   HS-grad     :10501   Min.   : 1.00    Divorced             : 4443  
##   Some-college: 7291   1st Qu.: 9.00    Married-AF-spouse    :   23  
##   Bachelors   : 5355   Median :10.00    Married-civ-spouse   :14976  
##   Masters     : 1723   Mean   :10.08    Married-spouse-absent:  418  
##   Assoc-voc   : 1382   3rd Qu.:12.00    Never-married        :10683  
##   11th        : 1175   Max.   :16.00    Separated            : 1025  
##  (Other)      : 5134                    Widowed              :  993  
##             occupation            relationship                    race      
##   Prof-specialty :4140    Husband       :13193    Amer-Indian-Eskimo:  311  
##   Craft-repair   :4099    Not-in-family : 8305    Asian-Pac-Islander: 1039  
##   Exec-managerial:4066    Other-relative:  981    Black             : 3124  
##   Adm-clerical   :3770    Own-child     : 5068    Other             :  271  
##   Sales          :3650    Unmarried     : 3446    White             :27816  
##   Other-service  :3295    Wife          : 1568                              
##  (Other)         :9541                                                      
##       sex         capital-gain    capital-loss    hours-per-week 
##   Female:10771   Min.   :    0   Min.   :   0.0   Min.   : 1.00  
##   Male  :21790   1st Qu.:    0   1st Qu.:   0.0   1st Qu.:40.00  
##                  Median :    0   Median :   0.0   Median :40.00  
##                  Mean   : 1078   Mean   :  87.3   Mean   :40.44  
##                  3rd Qu.:    0   3rd Qu.:   0.0   3rd Qu.:45.00  
##                  Max.   :99999   Max.   :4356.0   Max.   :99.00  
##                                                                  
##         native-country     label      
##   United-States:29170    <=50K:24720  
##   Mexico       :  643    >50K : 7841  
##   ?            :  583                 
##   Philippines  :  198                 
##   Germany      :  137                 
##   Canada       :  121                 
##  (Other)       : 1709
```

The summary overview provides a snapshot of the data spread and averages. From this, we see this dataset includes a disproportionate number of middle-age, white, US-born, private-sector employees. There appears to be a fairly even distribution of individuals across occupational sectors

## Research Questions

In this study, we will explore the relationships between personal attributes and quantitative income-related variables with the goal of identifying relationships and interesting patterns. Specifically, we will focus on addressing the following exploratory research questions: 

1. Is there an observable relationship between personal attributes data and income level?
2. Does the number of hours worked per week relate more to occupation, sex, race or age?
3. What is the relationship between education and hours worked per week (e.g. does a person work fewer hours if they have completed more schooling)?

## Plan of Action

The variables that effect income may be confounding and are unlikely to be direct, therefore these data may not be appropriate for linear regression analyses. We will focus on exploring the relationships variables and identifying relationships and patterns. 


## References

United States Census Bureau, 2016. Income and Poverty, 'about income'. https://www.census.gov/topics/income-poverty/income/about.html

University of California Irvine, Machine Learning Repository. https://archive.ics.uci.edu/ml/datasets/adult.
