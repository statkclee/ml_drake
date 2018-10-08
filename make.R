# 1. 데이터 -----
source("00_packages.R")
source("01_import_data.R")
source("02_feature.R")
source("03_predictive_model.R")
source("04_performance.R")


plan <- drake_plan(
    rmarkdown::render(
        knitr_in("model_report.Rmd"),
        output_file = file_out("report.html"),
        quiet = TRUE
    )
)

plan

make(plan)
