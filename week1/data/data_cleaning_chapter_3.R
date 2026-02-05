penguins_clean_names <- readRDS(url("https://github.com/UEABIO/5023B/raw/refs/heads/2026/files/penguins.RDS"))
library(tidyverse)
str_trim(" Adelie Penguin (Pygoscelis adeliae) ")
str_squish("  Adelie    Penguin   (Pygoscelis   adeliae)  ")
str_trunc("Adelie Penguin (Pygoscelis adeliae)", width = 18, side = "right")
str_split("Adelie Penguin (Pygoscelis adeliae)", " ")
str_c("Adelie", "Penguin", sep = "_")
# Print only unique character strings in this variable
penguins_clean_names |>  
  distinct(sex)
# use mutate and case_when 
# for a statement that conditionally changes 
# the names of the values in a variable
penguins_clean_names |> 
  mutate(species = case_when(
    species == "Adelie Penguin (Pygoscelis adeliae)" ~ "Adelie",
    species == "Gentoo penguin (Pygoscelis papua)" ~ "Gentoo",
    species == "Chinstrap penguin (Pygoscelis antarctica)" ~ "Chinstrap",
    .default = as.character(species)
  )
  )
# use mutate and if_else
# for a statement that conditionally changes 
# the names of the values in a variable
penguins_clean_names |> 
  mutate(sex = if_else(
    sex == "MALE", "Male", "Female"
  )
  )
# use mutate and case_when 
# for a statement that conditionally changes 
# the names of the values in a variable
penguins_clean_names |> 
  mutate(species = stringr::word(species, 1)
  ) |> 
  mutate(sex = stringr::str_to_title(sex))

penguins_clean_names |> 
  separate(
    species,
    into = c("species", "full_latin_name"),
    sep = "(?=\\()"
  ) 
#detecting patterns
str_detect("Genus specificus", "Genus")
# 3 possible names in species column
penguins_clean_names |> distinct(species)
penguins_clean_names |>
  filter(str_detect(species, "papua")) |>
  select(species)
# remove match for Genus (followed by a whitespace)
str_remove("Genus specificus", pattern = "Genus ")
penguins_clean_names |> 
  separate(
    species,
    into = c("species", "full_latin_name"),
    sep = "(?=\\()" # regex pattern: split before the '('
  ) |> 
  mutate(full_latin_name = str_remove_all(full_latin_name, "[\\(\\)]"))
