penguins_clean_names <- readRDS(url("https://github.com/UEABIO/5023B/raw/refs/heads/2026/files/penguins.RDS"))))
library(skimr)
skimr::skim(penguins_clean_names)
penguins_clean_names |> 
  filter(if_any(everything(), is.na)) |>
  select(culmen_length_mm, culmen_depth_mm, flipper_length_mm, 
         sex, delta_15n, delta_13c,comments,
         everything()) # reorder columns
penguins_clean_names |> 
  filter(if_any(culmen_length_mm, is.na))  # reorder columns
#drop all rows with missing values.
penguins_clean_names |> 
  drop_na()
#keep missing values in the dataset but ignore them only when performing calculations.
penguins_clean_names |> 
  group_by(species) |> 
  summarise(
    mean_body_mass = mean(body_mass_g, na.rm = T)
  )
