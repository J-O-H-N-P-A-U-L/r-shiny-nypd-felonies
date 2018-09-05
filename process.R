library(shiny)
library(leaflet)
library(dplyr)
library(tidyr)
library(tidyverse)

# our dataset has more than 1,000,000 rows, which means that the app will try to do everything 
# in global.R at every launch. This causes an increase in the app launch time which is not ideal. 
# Instead we will process beforehand and save the processed dataset as an .rds 
# file which is a serialized version of the dataset and compresses it using .gzip compression. 
# This will save us time every time we launch our app.
df = read.csv("./NYPD_7_Major_Felony_Incidents.csv", stringsAsFactors = F)

# First, we will split the column and create two separate columns named Latitude and Longitude.
# In order to do this, we will use separate function from the tidyverse/tidyr package:
df <- tidyr::separate(data=df,
                      col=Location.1,
                      into=c("Latitude", "Longitude"),
                      sep=",",
                      remove=FALSE)

# we don’t need “(” or “)” so we will remove using stringr::str_replace_all
# from the tidyverse/stringr package:
df$Latitude <- stringr::str_replace_all(df$Latitude, "[(]", "")
df$Longitude <- stringr::str_replace_all(df$Longitude, "[)]", "")

# In order to convert theLatitude and Longitude columns to numeric, we will use the as.numeric() 
# base R function:
df$Latitude <- as.numeric(df$Latitude)
df$Longitude <- as.numeric(df$Longitude)
saveRDS(df, "./data.rds")

# take 1,000 points and saved them as a .rds file. Then, in global.R read the small dataset 
# takING a much shorter amount of time:

sample_data <- df[c(1:1000),]
saveRDS(sample_data, "./sample_data.rds")
