library('ProjectTemplate')
load.project()

library(dplyr)
library(ggplot2)
library(scales)
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
(all_months_final_data)

#Calculating the ratio of leaving the course week wise in percentage
all_month_week_leave_ratio <- all_months_final_data %>%
  group_by(last_completed_week_number) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  


#plotting the ratio of leaving the course week wise in percentage
ggplot(all_month_week_leave_ratio, aes(x = "", y = perc, fill = as.character(last_completed_week_number))) +
  geom_col() +
  geom_col(color = "black") +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(label = Percentage_labels),
            position = position_stack(vjust = 0.5)) +
  guides(fill = guide_legend(title = "Week Number")) +
  scale_fill_brewer(palette="Spectral")

ggsave(file.path("graphs", "week_leave_ratio.png"))


#------------------------At what step number did the majority and least number of persons abandon the course?------------------
(all_months_final_data)

#Calculating the ratio of leaving the course week wise in percentage
all_month_step_ratio <- all_months_final_data %>%
  group_by(last_completed_step) %>% # Variable to be transformed
  count() %>%
  ungroup() %>% 
  filter(n %in% (2:60) )

#Creating a plot for step wise.
ggplot(data = all_month_step_ratio, aes(x = as.character(last_completed_step), y = n,)) +
  geom_bar(stat = "identity", fill="steelblue") + xlab("Week Number") + ylab("Number of Students")

ggsave(file.path("graphs", "stepwise_completed_ratio.png"))


#--------------------What was the average score month wise ------------------------------

#Calculating the completion rate in percentage for february month
february_question_res_perf <- feb_2018_question_response %>%
  group_by(correct) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  %>%
  mutate(intake = "February 2018")

#Calculating the completion rate in percentage for june month
june_question_res_perf <- june_2018_question_response %>%
  group_by(correct) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  %>%
  mutate(intake = "June 2018")

#Calculating the completion rate in percentage for September month
sept_question_res_perf <- sept_2018_question_response %>%
  group_by(correct) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  %>%
  mutate(intake = "September 2018")

#Calculating the concatenation of completion rate of different months
all_month_res_perf = rbind(february_question_res_perf,
                           june_question_res_perf,
                           sept_question_res_perf)

#Making it readable and categorical
all_month_res_perf$correct[
  which(all_month_res_perf$correct == "true")
] = "Correct Answer"

all_month_res_perf$correct[
  which(all_month_res_perf$correct == "false")
] = "Incorrect Answer"


ggplot(
  all_month_res_perf,
  aes(fill = correct, y = Percentage_labels, x = intake)
) +
  geom_bar(position = "dodge", stat = "identity") +
  scale_fill_brewer(palette = "Set3") +
  labs(x = "Type of Intake",
       y = "Percentage of students",) +
  guides(fill = guide_legend(title = "Is Answer correct?"))


ggsave(file.path("graphs", "quiz_response_ratio.png"))


#--------------------------What was the reason for leaving the course Pie Chart?--------------------




all_month_leave_reason_ratio = all_months_final_data %>%
  filter(leaving_reason != "I prefer not to say" & leaving_reason != "Other") %>%
  group_by(leaving_reason) %>% # Variable to be transformed
  count() %>%
  ungroup() %>%
  mutate(perc = `n` / sum(`n`)) %>%
  arrange(perc) %>%
  mutate(Percentage_labels = scales::percent(perc))  


#plotting the ratio of leaving the course week wise in percentage
ggplot(all_month_leave_reason_ratio, aes(x = "", y = perc, fill = leaving_reason)) +
  geom_col() +
  geom_col(color = "black") +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(label = Percentage_labels),
            position = position_stack(vjust = 0.5)) +
  guides(fill = guide_legend(title = "Leaving Reason")) +
  scale_fill_brewer(palette="Spectral")

ggsave(file.path("graphs", "leaving_reason_pie.png"), width=7)



