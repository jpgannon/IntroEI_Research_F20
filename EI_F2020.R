# EI Streamdata Project 
# cheunga

#packages
library(ggplot2)
library(tidyverse)
library(installr)
library(usethis)
library(lubridate)

#git setup
# use_git_config(user.name = "#USERNAME", 
#                user.email = "#EMAIL")
#


#TO DO

#main stem data -- site location : "MS"
#Temp vs Distance (Site locations file)

#example plots
#easily changeable dates for plot maker


#READ INS

#joins stream data and sensor locations
locations <- read.csv("SensorData/Sensor_Locations.csv")
tempdata <-
  list.files(pattern = "*.csv") %>%
  map_dfr(~read_csv(.) %>%
            mutate(Sensor = .x)) %>%
  mutate_at("Sensor", str_trunc, width = 10, side='right', ellipsis = '') %>%
  mutate_at("Sensor", str_replace_all, pattern = ' ', replacement = '')
tempdata <- left_join(tempdata, locations, by = c("Sensor" = "SensorID")) %>%
  drop_na()%>%
  filter(DateTime < mdy_hms("11-01-2020 01:00:00") | DateTime > mdy_hms("11-01-2020 02:00:00")) #cuts out daylight savings


#GRAPHS

#chooses date and time to use
chooseDate <- mdy_hms("08-08-2020 14:00:00")

#graph of chooseDate (Sensor # / Latitude)
tempdata %>% 
  filter(Type == "Stream",
         DateTime == chooseDate) %>%
  ggplot(aes(Sensor, Lat)) + 
  geom_point()

