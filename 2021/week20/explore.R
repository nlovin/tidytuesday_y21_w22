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
library(tidyverse)
library(janitor)

glimpse(bb)
glimpse(zip)

zip_geo <- tigris::zctas()

glimpse(zip_geo)


tbl <- zip_geo %>% 
  left_join(zip, by = c("GEOID10"))

plot(tbl$geometry)

tbl
