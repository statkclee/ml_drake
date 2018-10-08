source("00_packages.R")

# library(readxl)

# raw_data  <- read_xlsx("data/raw_data.xlsx")

raw_df  <- read_csv("data/data_adult.csv")

m_df <- raw_df %>% 
    mutate(marital.status = ifelse(str_detect(marital.status, "Married"), "Married", marital.status)) %>% 
    filter(workclass != "Without-pay") %>% 
    mutate_if(is.character, as.factor)
    

