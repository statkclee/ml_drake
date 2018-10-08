# source("00_packages.R")

raw_df  <- read_csv("data/data_adult.csv") %>% 
    sample_frac(0.1)



