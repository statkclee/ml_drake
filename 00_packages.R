
# https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them

list_of_packages <- c("tidyverse", "randomForest", "drake", "MASS", "broom", "caret", "cowplot", "doSNOW")

new_packages <- list_of_packages[!(list_of_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

lapply(list_of_packages, require, character.only = TRUE)
