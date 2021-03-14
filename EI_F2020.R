# EI Streamdata Project 
# cheunga

#packages
library(ggplot2)
library(tidyverse)
library(installr)
library(usethis)


#git setup
# use_git_config(user.name = "#USERNAME", 
#                user.email = "#EMAIL")
#

#read-ins
tempdata <-
  list.files(pattern = "*.csv") %>% 
  map_dfr(~read_csv(.) %>% 
            mutate(Sensor = .x)) %>%
  mutate_at("Sensor", str_trunc, width = 10, side ='right', ellipsis = '') %>%
  mutate_at("Sensor", str_replace_all, pattern = ' ', replacement = '')

#main stem data -- site location : "MS"
#Temp vs Distance (Site locations file)

#example plots
#easily changeable dates for plot maker