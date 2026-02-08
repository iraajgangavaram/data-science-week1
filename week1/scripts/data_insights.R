library(tidyverse)
library(here)
library(naniar)
library(janitor)
library(skimr)
penguins <- readRDS(url("https://UEABIO/5023B/raw/refs/heads/2026/files/penguins.RDS"))
glimpse(penguins)
#summary of counts of different variables.
penguins |> 
  filter(species == "Adelie") |> 
  count()
#apply multiple grouping parameters at the same time
penguins |> 
  group_by(species,sex) |> 
  count() |> 
  arrange(desc(n))
#Graphs
penguins |> 
  group_by(species,sex) |> 
  count() |> 
  arrange(desc(n)) |> 
  ggplot(aes(x = species,
             y = n,
             fill = sex))+
  geom_col(position=position_dodge2(preserve="single"))+
  coord_flip()+
  labs(x = "")+
  theme(legend.position = "bottom")
#scatter plot
penguins|>
  ggplot(aes(x = bill_len,
             y = bill_dep)) +
  geom_point(alpha = 0.7)
#Correlation provides such a summary by describing 
#the strength and direction of a linear association between two variables.
#we calculate the overall correlation between 
#culmen length and culmen depth across all observations.
penguins |>
  summarise(
    r = cor(bill_len,
            bill_dep,
            use = "complete.obs") # Important to include if there are any missing values
  )
#summary statistics
penguins |>
  group_by(species) |> # Calculate withing groups
  summarise(
    mean_mass = mean(body_mass, na.rm = TRUE),
    sd_mass = sd(body_mass, na.rm = TRUE),
    n = n(),
    median = median(body_mass, na.rm = TRUE),
    iqr = IQR(body_mass, na.rm = TRUE)
  )
#Summarise specific selected variables
penguins |> 
  group_by(species) |> 
  summarise_at(c("flipper_len",
                 'bill_len',
                 "bill_dep"),
               mean, na.rm =T) # mean function
#summarise if
penguins |> 
  group_by(species) |> 
  summarise_if(is.numeric, # selects only numeric columns
               mean, na.rm =T)
# visualise the distribution of body mass across penguin species.
penguins |>
  ggplot(aes(x = species,
             y = body_mass)) +
  geom_boxplot() +
  coord_flip()
#ggally
library(GGally)
penguins |> 
  ggpairs(columns = 10:12, ggplot2::aes(colour = species))