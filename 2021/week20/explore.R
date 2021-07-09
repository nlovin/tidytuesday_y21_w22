# Load some packages
library(tidyverse)
library(janitor)
library(sf)

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load(2021, week = 20)

bb <- tuesdata$broadband
zip <- tuesdata$broadband_zip %>% janitor::clean_names()

# need to add leading zeroes to the zipcode
zip <- zip %>% 
  mutate(GEOID10 = str_pad(postal_code,5,"left" ,"0")) %>% 
  select(GEOID10, everything())


# Explore data

glimpse(bb)
glimpse(zip)

# don't end up using this -- file is WAY too much (~800mb)
#options(tigris_use_cache = TRUE)
#zip_geo <- tigris::zctas()

# created a simplified file using qgis
zip_shp <- read_sf("2021/week20/data/zip_shp_sm/tl_2019_us_zcta510.shp")

glimpse(zip_shp)

# join shapefile to our data and keep only the lower 48 (for simple maps) -- we'll add HI and AK back later
tbl <- zip_shp %>% 
  inner_join(zip, by = c("GEOID10")) %>% 
  filter(st != 'AK' & st != 'HI')

# quick plot to check it
plot(tbl$geometry)