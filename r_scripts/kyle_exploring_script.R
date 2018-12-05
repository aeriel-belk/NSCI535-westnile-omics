library(readr)
library(tidyverse)
library(stringr)

wn_meta_filtered <- read.csv("metadata/metadata.csv") %>% 
  select(Scripps.ID, Species, Sample.type, Collection.date, County, Latitude, Longitude)

wn_meta_filtered %>% 
  ggplot() +
  geom_bar(aes(x = County)) +
  scale_x_discrete(fct_reorder(County, .desc = TRUE))

wn_meta_filtered %>% 
  group_by(Species) %>% 
  ggplot() +
  geom_bar(aes(x = Species)) +
  facet_wrap(~ Sample.type, nrow = 2)
