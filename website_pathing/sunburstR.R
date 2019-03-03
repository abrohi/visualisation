
rm(list = ls())
##http://timelyportfolio.github.io/sunburstR/example_baseball.html
##
##http://www.buildingwidgets.com/blog/2015/7/2/week-26-sunburstr
##
##

if(!require("pacman")) install.packages("pacman")
pacman::p_load(sunburstR, pitchRx, tidyverse)

# read in sample visit-sequences.csv data provided in source
#   https://gist.github.com/kerryrodden/7090426#file-visit-sequences-csv
sequence_data <- read.csv(
  paste0(
    "https://gist.githubusercontent.com/kerryrodden/7090426/"
    ,"raw/ad00fcf422541f19b70af5a8a4c5e1460254e6be/visit-sequences.csv"
  )
  ,header=F
  ,stringsAsFactors = FALSE
)


sunburst(sequence_data)


##using paths data extracted from adobe for the month May
##
setwd("C:\\Users\\amir.brohi\\Downloads")

data <- read.csv("next_pages.csv", header = T)


##extracting mobile data only

mobile_data <- data %>%
  filter(grepl("mobile", Next.Pages)) %>%
  filter(Visits >=250) %>% ##using summary to get the mean of visits
  select(Next.Pages, Visits) %>%
  arrange(desc(Visits))


##extracting desktop data only

desktop_data <- data %>%
  filter(!grepl("mobile", Next.Pages)) %>%
  filter(Visits >=600) %>%
  select(Next.Pages, Visits) %>%
  arrange(desc(Visits))


# ##filtering data for only visits containing more than 500 visits
# data <- data %>%
#   select(Next.Pages, Visits) %>%
#   filter(Visits >= 500) %>%
#   arrange(desc(Visits))

##renmaing columns
colnames(desktop_data)[1] <- "paths"
colnames(mobile_data)[1] <- "paths"

##making it into the right format for mobile
mobile_data$paths <- gsub(":", "-", mobile_data$paths)
mobile_data$paths <- gsub("mobile-", "", mobile_data$paths) ##removing the page mobile in path

mobile_data$paths <- paste0(mobile_data$paths, "-end") ##including end in path


##making it into the right format for desktop
desktop_data$paths <- gsub(":", "-", desktop_data$paths)
desktop_data$paths <- paste0(desktop_data$paths, "-end") ##including end in path



sunburst(desktop_data, count = T) ##charting the sunburst chart

