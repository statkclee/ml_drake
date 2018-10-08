# source("01_import_data.R")

m_df <- raw_df %>% 
    mutate(marital.status = ifelse(str_detect(marital.status, "Married"), "Married", marital.status)) %>% 
    filter(workclass != "Without-pay") %>% 
    mutate_if(is.character, as.factor)
    

