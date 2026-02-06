# Week 1: Initial Data Exploration ====
# Author: [Iraaj Gangavaram]
# Date: [30 january 2026]

# Load packages ====
library(tidyverse)
library(here)
library(naniar)
library(janitor)
library(skimr)
# Load data ====
mosquito_egg_raw <- read_csv(here('week1', "data", "mosquito_egg_data.csv"),
                             name_repair = janitor::make_clean_names)

# Basic overview ====
glimpse(mosquito_egg_raw)
#null values are present.
summary(mosquito_egg_raw)
skim(mosquito_egg_raw)

# React table====
# view interactive table of data
view(mosquito_egg_raw)


# Counts by site and treatment====

mosquito_egg_raw |> 
  group_by(site, treatment) |> 
  summarise(n = n())

# Observations ====
# Your observations (add as comments below):
# - What biological system is this?
#   mosquito
# - What's being measured?
#   body mass mg
# - How many observations?
#   205
# - Anything surprising?
#   null values
# - Any obvious problems?
# only null values

# FIX 1: [Which variables have the most missing values and 
#how does missingness affect grouped summaries like mean(body_mass_mg) by
#species when na.rm=FALSE vs na.rm=TRUE?] ====

# Show the problem:
# [Code to demonstrate issue exists]
mosquito_egg_data |>
  filter(if_any(everything(), is.na))


# Fix it:

  
  # YOUR CODE HERE
#dropping all null values
mosquito <- mosquito_egg_data |>
  drop_na() 
  
  # Verify it worked:
  # [Code to check change happened]
glimpse(mosquito)  
  
  # What changed and why it matters:
  # [2-3 sentences explaining consequences]
  # The null values were removed. this makes sure that the null values dont 
#interfere with the summary statistics or data analysis done with the 
#mosquito data.
  
  
  # FIX 2: [Are the ranges of numeric variables biologically plausible, and are there any impossible values 
#(bopdy mass mg) or extreme outliers that need investigation?]  ====

# Show the problem:
# [code]
glimpse(mosquito) 

# Fix it:
  # YOUR CODE
  mosquito <- mosquito_egg_data |>
  filter(body_mass_mg >= 10)
  
  # Verify it worked:
  # [Code]
  glimpse(mosquito) 
  # What changed and why it matters:
  # [2-3 sentences]
  #removed body_mass_mg values that were below 10 mg because those are impossible values.
  #changing that makes sure the impossible values are removed and this would positively 
  #affect any data analysis we do on the data.

#issues from Connor's github.
  ### Duplications ###############################################################
  mosquito_egg_data |>
    get_dupes()
  
  # Keep only unduplicated data with !
  mosquito_new <- mosquito_egg_data |> 
    filter(!duplicated(across(everything()))) 
  
  mosquito_new |>
    get_dupes()  # checking the new data set for dupes
  
  ## NAs #########################################################################
  mosquito_new |> 
    filter(if_any(everything(), is.na)) # selects all columns in order for the NAs
  
