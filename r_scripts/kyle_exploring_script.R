library(readr)
library(tidyverse)
library(stringr)
library(ggthemes)

wn_meta_filtered <- read.csv("metadata/metadata.csv") %>% 
  select(Scripps.ID, Species, Sample.type, Collection.date, County, Latitude, Longitude)

wn_meta_sum_county <- wn_meta_filtered %>% 
  group_by(County) %>% 
  summarize(
    n = n()) %>% 
  ungroup()

wn_meta_sum_county %>%
  mutate(County = fct_reorder(County, n)) %>% 
  ggplot(aes(x = County, y = n)) +
  geom_point() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Samples collected by county", x = NULL, y = "# of samples")

wn_meta_sum_species <- wn_meta_filtered %>% 
  filter(Sample.type == "Tissue") %>% 
  group_by(Species) %>% 
  summarize(
    n = n()) %>% 
  ungroup()

wn_meta_sum_species %>%
  mutate(Species = fct_reorder(Species, n)) %>% 
  ggplot(aes(x = Species, y = n)) +
  geom_point() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Samples collected by bird species", x = NULL, y = "# of samples")    

wn_meta_sum_mosquitos <- wn_meta_filtered %>% 
  filter(Sample.type == "Pooled mosquitos") %>% 
  group_by(Species) %>% 
  summarize(
    n = n()) %>% 
  ungroup()

wn_meta_sum_mosquitos %>%
  mutate(Species = fct_reorder(Species, n)) %>% 
  ggplot(aes(x = Species, y = n)) +
  geom_point() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Samples collected by mosquito species", x = NULL, y = "# of samples")    
