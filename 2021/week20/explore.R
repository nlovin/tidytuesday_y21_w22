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

# get pop data by zip
zip_pop <- read_csv("2021/week20/data/us_zip_pop.csv") %>% 
  mutate(GEOID10 = str_pad(zip,5,"left" ,"0")) %>% 
  select(GEOID10, everything())

zp <- zip_pop %>% select(GEOID10, type, decommissioned,primary_city,pop = irs_estimated_population_2015)

# Explore data

glimpse(bb)
glimpse(zip)

# created a simplified file using qgis
zip_shp <- read_sf("2021/week20/data/zip_shp_sm/tl_2019_us_zcta510.shp")

glimpse(zip_shp)

# join shapefile to our data and keep only the lower 48 (for simple maps) -- we'll add HI and AK back later
tbl <- zip_shp %>% 
  inner_join(zip, by = c("GEOID10")) %>% 
  filter(st != 'AK' & st != 'HI')

# quick plot to check it
plot(tbl$geometry)


### Large ZIP File, smaller geographical area -----

# don't end up using this for the entire US-- file is WAY too much (~800mb)
options(tigris_use_cache = TRUE)
zip_geo <- tigris::zctas()

# DC, VA, MD
dmv <- zip_geo %>% 
  inner_join(zip %>% 
               filter(st == 'VA' | st == 'MD' | st == 'DC'), 
             by = c("GEOID10"))


# add pop
