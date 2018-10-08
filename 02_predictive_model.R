source("01_import_data.R")

income_glm <- glm(income~., data = m_df, family = 'binomial')

income_best_glm <- stepAIC(income_glm)

# summary(income_best_glm)

