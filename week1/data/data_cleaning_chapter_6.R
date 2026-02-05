penguins_clean_names <- readRDS(url("https://github.com/UEABIO/5023B/raw/refs/heads/2026/files/penguins.RDS"))
library(lubridate)
# library(tidyverse)
date("2017-10-11T14:02:00")
#We can use % to be more explicit about what information is in each part of our date column, specifying where the 4-digit year (%Y), 2-digit month (%m) and 2 digit day (%d) are within each string.
df |> 
  mutate(
    date = as_date(date, format = "X%Y.%m.%d")
  )
#This means that sometimes the date is imported into R as the numeric (number of days since origin).
library(janitor)

excel_numeric_to_date(42370)
#calculations
penguins_clean_names |> 
  summarise(min_date=min(date_egg),
            max_date=max(date_egg))
#make new columns from our date column
penguins_clean_names <- penguins_clean_names |> 
  mutate(year = lubridate::year(date_egg))
#exclude data from certain dates or date ranges.
