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

#####################################################################################################
#
# 1) Set up working directory - Load libraries
#
#####################################################################################################

setwd("C:/Users/joao_/Dropbox/Data Science/UCLA/Data")

library(tidyverse) # Includes ggplot2
library(dplyr)
library(readxl)

library(readxl) 
library(tidyverse)
library(dplyr)
library(tidyr)
library(data.table)
library(ggplot2)
library(stringr)
library(DT)
library(corrplot)
library(lubridate)

#####################################################################################################
#
# 2) Load / Clean Data
#
#####################################################################################################

wdi <- data.frame(read_excel("W03b_wdi.xlsx"))     # World Development Indicators

remove1 <- c("X1960","X1961","X1962","X1963","X1964","X1965","X1966","X1967","X1968","X1969",
          "X1970","X1971","X1972","X1973","X1974","X1975","X1976","X1977","X1978","X1979","X1980")

# Remove years from 1960 to 1980
wdi=wdi[,!names(wdi) %in% remove1]

# Region country code
remove2 <- c("ARB","CEB","CSS","EAP","EAR","EAS","ECA","ECS","EUU","HIC","HPC","IBD","IBT","IDA","IDX",
          "LAC","LCN","LDC","LIC","LMC","LMY","MEA","MIC","MNA","NAC","OED","OSS","PRE","PSS","PST",
          "SAS","SSA","SSF","SST","TEA","TEC","TLA","TMN","TSA","UMC","WLD","FCS")

# Remove those regions, non-country data rows
wdi <- wdi %>% filter(!Country.Code %in% remove2)

# Subset data for dependent variable poverty gap in $3.2 
poverty <-  wdi %>% filter(Indicator.Code %in% "SI.POV.LMIC.GP")

# Select those countries that have poverty data in 2012
pov12 <-  poverty %>% filter(!X2012 %in% NA)

pov12.list <- pov12$Country.Code %>% table() %>% names()

# Subset wdi with those countries with poverty data in 2012
wdi.pov <- wdi %>% filter(Country.Code %in% pov12.list)

# Transport the data frame between years and variables
wdi.povt <- dcast(melt(as.data.table(wdi.pov), id.vars = c("Country.Name", 
                                                        "Country.Code","Indicator.Name", "Indicator.Code")), 
               Country.Name + Country.Code + variable ~ Indicator.Code, value.var = "value")

# Calculating missing values percentage
missing <- wdi.povt %>% summarize_all(funs(sum(is.na(.))/n()))
missing <- gather(missing, key="feature", value="missing_pct")
goodv <- filter(missing, missing_pct<0.25)
goodvalues <-as.vector(goodv[,1])
goodvalues <- append(goodvalues, "SI.POV.LMIC.GP")

which( colnames(wdi.povt)=="SI.POV.LMIC.GP" )

pdata <- subset(wdi.povt,select=c("Country.Name", goodvalues))
pdata1 <- pdata[,-c(1:3)]

which( colnames(pdata1)=="SI.POV.LMIC.GP" )

# Remove X from "variable"
pdata1$variable <- pdata1$variable %>%  str_replace(".*X","")

# Transform to numeric
pdata1$variable <- as.numeric(pdata1$variable)

# str(pdata)
cor(pdata1, use="complete.obs")
corrplot(cor(pdata1, use="complete.obs"),type="lower")

pdata2 <- pdata[,-c(1)]
cor(pdata2, use="complete.obs")
corrplot(cor(pdata2, use="complete.obs"),type="lower")

# which( colnames(pdata)=="SI.POV.LMIC.GP" )
