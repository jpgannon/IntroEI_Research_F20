install.packages("tidyverse")
library("tidyverse")

locations <- read_csv("Sensor Locations.csv")
setwd("~/Google Drive File Stream/My Drive/Brush Mtn Station/Temp sensors/CurrentTempData_15Jan2021")
#setwd("G:/My Drive/Independent Study Fall 2020/McDonald_Hollow/CurrentTempData_15Jan2021")
tempdata <-
  list.files(pattern = "*.csv") %>%
  map_dfr(~read_csv(.) %>%
            mutate(Sensor = .x)) %>%
  mutate_at("Sensor", str_trunc, width = 10, side='right', ellipsis = '') %>%
  mutate_at("Sensor", str_replace_all, pattern = ' ', replacement = '')
tempdata <- left_join(tempdata, locations, by = c("Sensor" = "SensorID")) %>%
  drop_na()%>%
  filter(DateTime < mdy_hms("11-01-2020 01:00:00") | DateTime > mdy_hms("11-01-2020 02:00:00")) #cuts out daylight savings


