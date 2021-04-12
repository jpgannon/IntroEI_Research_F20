# EI Streamdata Project 
# cheunga

#packages
library(ggplot2)
library(tidyverse)
library(installr)
library(usethis)
library(lubridate)

install.packages(c("ggplot2","tidyverse","lubridate"))
#git setup
# use_git_config(user.name = "#USERNAME", 
#                user.email = "#EMAIL")
#


#TO DO

#main stem data -- site location : "MS"
#Temp vs Distance (Site locations file)

#example plots
#easily changeable dates for plot maker

#filter stream == ms & type == stream

#filter dry censors by std


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
  filter(Stream == "MS",
         Type == "Stream",
         Type != "Air",
         DateTime == chooseDate,
         TempCor_F < 72) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F)) + 
  geom_point()+
  labs(title = "Water Temp for Each Sensor on 08/08/2020",
       x = "Sensor Name",
       y = "Temperature (F)")

ggplot(aes(x = date, 
           y = , ))


#multiple dates
days_to_plot <- mdy_hms(c("01-10-2021 12:00:00", "12-10-2020 12:00:00", "11-10-2020 12:00:00",
                          "10-10-2020 12:00:00", "09-10-2020 12:00:00", "08-10-2020 12:00:00"))

days_graph <- tempdata_filtered %>% 
  filter(DateTime %in% days_to_plot) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F, 
             color = as.factor(DateTime), group = as.factor(DateTime))) + 
  geom_point()+
  geom_line()+
  labs(title = "Water Temp for Each Sensor on the 10th of Each Month",
       x = "Sensor Name",
       y = "Temperature (F)")

days_graph

#graph by heat
days_heat_graph <- tempdata_filtered %>% 
  filter(DateTime %in% days_to_plot) %>%
  ggplot(aes(x = factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                           "MS8", "MS9", "MS10", "MS11", "MS12",
                                         "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                         "MS19", "MS20", "MS21")), fill = TempCor_F, 
             y = as.factor(DateTime))) + 
  geom_tile()+
  labs(title = "Graphs by Heat for the 10th of Each Month",
       x = "Sensor Name",
       y = element_blank())

#time
days_heat_graph <- tempdata_filtered %>% 
  filter(DateTime > mdy("9-1-2020" ) & DateTime < mdy("10-1-2020")) %>%
  ggplot(aes(y = factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                         "MS8", "MS9", "MS10", "MS11", "MS12",
                                         "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                         "MS19", "MS20", "MS21")), fill = TempCor_F, 
             x = DateTime)) + 
  geom_tile()+
  labs(title = "Graphs by Heat for the 10th of Each Month",
       x = "Sensor Name",
       y = element_blank())
days_heat_graph

#set up max for cold and warm temperatures
coldest <- tempdata_filtered %>%
  filter(TempCor_F == min(TempCor_F))

warmest <- tempdata_filtered %>%
  filter(TempCor_F == max(TempCor_F))












#GRAPHS FOR THE 10TH OF EACH MONTH
tempdata_filtered <- tempdata %>%
  filter(Stream == "MS",
         Type == "Stream",
         Type != "Air",
         TempCor_F < 72)

#Graph of August 10
august_10 <- mdy_hms("08-10-2020 12:00:00")

aug_10_graph <- tempdata_filtered %>% 
  filter(DateTime == august_10) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F)) + 
  geom_point()+
  labs(title = "Water Temp for Each Sensor on 08/10/2020",
       x = "Sensor Name",
       y = "Temperature (F)")

#Graph of september_10
september_10 <- mdy_hms("09-10-2020 12:00:00")

sep_10_graph <- tempdata_filtered %>% 
  filter(DateTime == september_10) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F)) + 
  geom_point()+
  labs(title = "Water Temp for Each Sensor on 09/10/2020",
       x = "Sensor Name",
       y = "Temperature (F)")

#Graph of October 10
october_10 <- mdy_hms("10-10-2020 12:00:00")

oct_10_graph <- tempdata_filtered %>% 
  filter(DateTime == october_10) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F)) + 
  geom_point()+
  labs(title = "Water Temp for Each Sensor on 10/10/2020",
       x = "Sensor Name",
       y = "Temperature (F)")

#Graph of November 10
november_10 <- mdy_hms("11-10-2020 12:00:00")

nov_10_graph <- tempdata_filtered %>% 
  filter(DateTime == november_10) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F)) + 
  geom_point()+
  labs(title = "Water Temp for Each Sensor on 11/10/2020",
       x = "Sensor Name",
       y = "Temperature (F)")

#Graph of December 10
december_10 <- mdy_hms("12-10-2020 12:00:00")

dec_10_graph <- tempdata_filtered %>% 
  filter(DateTime == december_10) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F)) + 
  geom_point()+
  labs(title = "Water Temp for Each Sensor on 12/10/2020",
       x = "Sensor Name",
       y = "Temperature (F)")

#Graph of January 10
january_10 <- mdy_hms("01-10-2021 12:00:00")

jan_10_graph <- tempdata_filtered %>% 
  filter(DateTime == january_10) %>%
  ggplot(aes(factor(Name, levels = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7",
                                     "MS8", "MS9", "MS10", "MS11", "MS12",
                                     "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", 
                                     "MS19", "MS20", "MS21")), TempCor_F)) + 
  geom_point()+
  labs(title = "Water Temp for Each Sensor on 01/10/2021",
       x = "Sensor Name",
       y = "Temperature (F)")



#testing out patchwork
install.packages("patchwork")
library("patchwork")

aug_10_graph / sep_10_graph / oct_10_graph / nov_10_graph / dec_10_graph / jan_10_graph



# Day and Night datasets
# Day = 1100-1400; Night = 0100-0400

DayFilter <- tempdata_filtered %>%
  filter(hour(DateTime) > 10, hour(DateTime) < 14)

NightFilter <- tempdata_filtered %>%
  filter(hour(DateTime) > 0, hour(DateTime) < 4)



### Day data set box plots MONTH/TEMP
DayAvg <- DayFilter %>%
  mutate(date = month(DateTime)) %>%
  group_by(date)

AugBox <- DayAvg %>%
  filter(date == 8) %>%
  ggplot(aes(Name, TempCor_F)) +
  geom_boxplot() + 
  labs(title = "Auguest", 
       x = "Sensor",
       y = "Temp")

SeptBox <- DayAvg %>%
  filter(date == 9) %>%
  ggplot(aes(Name, TempCor_F)) +
  geom_boxplot() + 
  labs(title = "September", 
       x = "Sensor",
       y = "Temp")

OctBox <- DayAvg %>%
  filter(date == 10) %>%
  ggplot(aes(Name, TempCor_F)) +
  geom_boxplot() + 
  labs(title = "October", 
       x = "Sensor",
       y = "Temp")

NovBox <- DayAvg %>%
  filter(date == 11) %>%
  ggplot(aes(Name, TempCor_F)) +
  geom_boxplot() + 
  labs(title = "November", 
       x = "Sensor",
       y = "Temp")

DecBox <- DayAvg %>%
  filter(date == 12) %>%
  ggplot(aes(Name, TempCor_F)) +
  geom_boxplot() + 
  labs(title = "December", 
       x = "Sensor",
       y = "Temp")

JanBox <- DayAvg %>%
  filter(date == 1) %>%
  ggplot(aes(Name, TempCor_F)) +
  geom_boxplot() + 
  labs(title = "January", 
       x = "Sensor",
       y = "Temp")

(AugBox | SeptBox | OctBox)  / (NovBox | DecBox | JanBox)
# boxplots difficult to read. group by month and hard average temp per sensor location? 
# filter by std?



  
