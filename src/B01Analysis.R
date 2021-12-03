library('ProjectTemplate')
load.project()

library(dplyr)
library(ggplot2)
#---------------------getting plot for completion rate.-------------------

#Calculating the completion rate in percentage for february month
february_completion_rate <- feb_2018_enrollments_final %>%
  group_by(fully_participated_at) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  %>%
  mutate(intake = "February 2018")

#Calculating the completion rate in percentage for june month
june_completion_rate <- june_2018_enrollments_final %>%
  group_by(fully_participated_at) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  %>%
  mutate(intake = "June 2018")

#Calculating the completion rate in percentage for September month
sept_completion_rate <- sept_2018_enrollments_final %>%
  group_by(fully_participated_at) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  %>%
  mutate(intake = "September 2018")

#Calculating the concatenation of completion rate of different months
all_month_completion_rate = rbind(february_completion_rate,
                                  june_completion_rate,
                                  sept_completion_rate)

#plotting dodge bar chart
ggplot(
  all_month_completion_rate,
  aes(fill = fully_participated_at, y = Percentage_labels, x = intake)
) +
  geom_bar(position = "dodge", stat = "identity") +
  scale_fill_brewer(palette = "Dark2") +
  labs(x = "Type of Intake",
       y = "Completion Rate",) +
  guides(fill = guide_legend(title = "Participation status"))

#Saving this file in png so that it can be used in report
ggsave(file.path("graphs", "completion_rate_month.png"))


#--------------------------Which week did the most and least people drop out of the course?--------------------