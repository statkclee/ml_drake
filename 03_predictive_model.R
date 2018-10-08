# source("02_feature.R")

# 1. split train/test -----
income_index <- createDataPartition(m_df$income, times =1, p=0.3, list=FALSE)
 
train_df <- m_df[income_index, ]
test_df  <- m_df[-income_index, ]

# 2. cross validation for predictive models -----

cv_folds <- createMultiFolds(train_df$income, k = 5, times = 1)
cv_cntrl <- trainControl(method = "repeatedcv", number = 5, repeats = 1, index = cv_folds,
                         verboseIter = TRUE)


# 3. machine learning -----
start.time <- Sys.time()
 
cl <- makeCluster(4, type = "SOCK")
registerDoSNOW(cl)

income_gbm  <- train(income ~ ., data = train_df, 
                     method = "xgbTree",
                     # metric = "Sens",
                     metric = "Accuracy",
                     trControl = cv_cntrl, 
                     tuneLength = 3,
                     importance = TRUE)

stopCluster(cl)

total.time <- Sys.time() - start.time
total.time


