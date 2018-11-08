#####################################################################################################
#####################################################################################################
# Project X         Instructor: William Yu
# By Joao de Paula, UCLA Extension Data Science Intensive  
# Oct. 2018
##################################################################################################### 
#####################################################################################################

#####################################################################################################
#
# A. Predicting and Reduce Poverty  
#
#####################################################################################################

# Load Data from Week 3: W03b_wdi.xlsx

# Deal with some missing data - some countries don't have yearly data

 
# Predict - Dependeble variable Proverty gap (Only for Countries with 2012)
# Indicator Name Proverty gap at $3.20


# Find a good model - low error 
# ACF Autocorrelation function, Correlogram

# Use on testing set data

# Identity the most important variables (predictors) - 5 or more

# By knowing the predictors you can tell a good story focusing on those

##### AdjR2 --- highest possible
##### AIC, AICC, BIC, CV lowest possible

#####################################################################################################
#
# A. Predicting and Reduce Poverty  
#
#####################################################################################################

# Since its founding in 1944, the World Bank has been gathering data (WDI: World Development Indicators) 
# to help it alleviate poverty all cross the world. In this project, you will need to predict the 
# main goal indicator: poverty gap at $3.2 a day (2011 PPP, %; code: SI.POV.LMIC.GP) for those 
# countries that have available data in 2012

# The train data is form 1981 to 2012. The test data is from 2013 to 2016. There are complex relationship
# between poverty and other indicators in WDI. Your first task is to develop a forecast model which produce
# smallest test errors. In addition to prediction, your second task is find five major indicators which could
# predict poverty of a country. By doing so, the World Bank and United Nations will be able to follow those 
# predictors to reduce poverty

# Write a R markdown with both explanation and script for your problem-solving project. 

 
setwd("C:/Users/joao_/Dropbox/Data Science/UCLA/Data")

library(tidyverse) # Includes ggplot2
library(dplyr)
library(readxl)

wdi <- data.frame(read_excel("W03b_wdi.xlsx")) # World Development Indicators

# Remove those rows that are not countries but regions # !(NOT)
wdi_countries=wdi[!wdi$Country.Code %in% c("ARB",	"CSS",	"CEB",	"EAR",	"EAS",	"EAP",	"TEA",	"EMU",	"ECS",
                                                        "ECA",	"TEC",	"EUU",	"FCS",	"HPC",	"HIC",	"IBD",	"IBT",	"IDB",	
                                                        "IDX",	"IDA",	"LTE",	"LCN",	"LAC",	"TLA",	"LDC",	"LMY",	"LIC",	
                                                        "LMC",	"MEA",	"MNA",	"TMN",	"MIC",	"NAC",	"INX",	"OED",	"OSS",	
                                                        "PSS",	"PST",	"PRE",	"SST",	"SAS",	"TSA",  "SSF",	"SSA",	"TSS",
                                                        "UMC",	"WLD"),]

wdi.pr = subset(wdi_countries, Indicator.Code == "SI.POV.LMIC.GP")
indicators = unique(wdi_countries$Indicator.Name)

wdi3v.1960a=merge(wdi.le[,c("Country.Name","Country.Code","X1960")], wdi.po[,c("Country.Code","X1960")], by="Country.Code")
wdi3v.1960b=merge(wdi3v.1960a, wdi.fr[,c("Country.Code","X1960")], by="Country.Code")

## Transpose --- Convert to Time Series - Panel Data --- Year/Y/X1/X2 ....

mtcars %>%
  rownames_to_column %>% 
  gather(var, value, -rowname) %>% 
  spread(rowname, value) 


#  train data is form 1981 to 2012. 

# The test data is from 2013 to 2016

# colnames(wdi3v.1960)=c("code", "country", "life","pop","fr")



#####################################################################################################
#####################################################################################################
# 
# CODE SUBMITTED
#
#####################################################################################################
#####################################################################################################

