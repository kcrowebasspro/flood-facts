# Kevin Crowe
# Geog 576
# Spring 2024
# Midterm project

library(tidyverse)
library(tmap)
library(sf)
library(terra)
library(sp)
library(janitor)


# Load in the storm events downloaded here: 
# https://www.ncdc.noaa.gov/stormevents/listevents.jsp?eventType=%28Z%29+Coastal+Flood&eventType=%28C%29+Flash+Flood&eventType=%28Z%29+Flood&beginDate_mm=01&beginDate_dd=01&beginDate_yyyy=2017&endDate_mm=11&endDate_dd=30&endDate_yyyy=2023&county=MOBILE%3A97&hailfilter=0.00&tornfilter=0&windfilter=000&sort=DT&submitbutton=Search&statefips=1%2CALABAMA
flood.events <- read_csv("/Users/crowek/Documents/uw_gis/geog_576/flood-facts/data/storm_data_search_results.csv")
# Imports 77 records

# clean the column headers
flood.events <- clean_names(flood.events)

# Select only the records with coordinates
flood.events <- flood.events %>%
  filter(!is.na(begin_lat), !is.na(begin_lon))
# Result: 68 records 

# Create an SF object
flood.events.sf <- st_as_sf(flood.events, coords = c("begin_lon", "begin_lat"), crs = 4269)

# Check these on a leaflet map
flood.points <- tm_shape(flood.events.sf) +
  tm_dots(col = "goldenrod") 

# Looks good
tmap_leaflet(flood.points)

# write out the flood points


# Read in the shapefile of the special flood hazard areas
sfha.sf <- st_read("/Users/crowek/Documents/uw_gis/geog_576/flood-facts/data/fema_sfha/fema_sfha_mobile_county.shp")

# make the polygons valid
sfha.sf <- st_make_valid(sfha.sf)

# Check that on a leaflet map
tm_shape(sfha.sf) +
  tm_polygons(col = "blue")





















