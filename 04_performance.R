# source("02_predictive_model.R")



score_df <- tibble(
    label = test_df$income,
    score = predict(income_gbm, newdata=test_df, type="prob")[,2]
)

score_decile_df <- score_df %>% 
    mutate(decile = ntile(score, 10)) %>% 
    mutate(label = ifelse(label == "<=50K", "no", "yes")) %>% 
    count(decile, label) %>% 
    spread(label,n, fill=0)  %>% 
    mutate(decile = 11-decile) %>% 
    arrange(decile) %>% 
    mutate(total = no + yes, 
           cum_yes = cumsum(yes),
           cum_tot = cumsum(total)) %>% 
    mutate(gain = yes /sum(yes),
           cum_gains = cum_yes / sum(yes)) %>% 
    mutate(avg_resp = sum(yes)/sum(total)) %>% 
    mutate(lift = (yes/total) / avg_resp,
           cum_lift = (cum_yes/cum_tot) / avg_resp)

cumulative_gain_g <- score_decile_df %>% 
    ggplot(aes(x=decile, y=cum_gains)) +
    geom_point() +
    geom_line() +
    scale_y_continuous(limits=c(0,1), labels = scales::percent) +
    scale_x_continuous(breaks = seq(1,10)) +
    labs(x="Decile", y="Cumulative Gains", title="Cumulative Gains") +
    theme_minimal()

cumulative_lift_g <- score_decile_df %>% 
    ggplot(aes(x=decile, y=cum_lift)) +
    geom_point() +
    geom_line() +
    scale_x_continuous(breaks = seq(1,10)) +
    labs(x="Decile", y="Cumulative Lift", title="Cumulative Lifts") +
    theme_minimal()

pm_performance_g <- plot_grid(cumulative_gain_g, cumulative_lift_g)

