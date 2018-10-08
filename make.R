# 1. 데이터 -----
source("01_import_data.R")
source("02_predictive_model.R")
source("03_performance.R")


plan <- drake_plan(
    rmarkdown::render(
        knitr_in("model_report.Rmd"),
        output_file = file_out("report.html"),
        quiet = TRUE
    )
)

plan

make(plan)
