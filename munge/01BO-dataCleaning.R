# Data Preparation script.

#loading required libraries
library(plyr)

#--------------------------------------February Data---------------------------------------
#Getting csv files for february intake of 2018
feb_2018_csv_list = list.files(path="data", pattern="^cyber-security-5_(.*)csv$", full.names = TRUE)

#Printing the list for sequence
(feb_2018_csv_list)

#Getting all csv data in a list
feb_2018_csv = lapply(feb_2018_csv_list, read.csv)

#Since we want enrollments data and leaving survey responses, the position is 2 and 3 respective
feb_2018_enrollments = data.frame(feb_2018_csv[[2]])


#Pick required columns
feb_2018_enrollments_final = feb_2018_enrollments[,
                                                  c("learner_id",
                                                    "enrolled_at",
                                                    "role",
                                                    "fully_participated_at")]


#Applying filter for role as learner
feb_2018_enrollments_final <- filter(feb_2018_enrollments_final, role == "learner")

#Converting fully_participated_at as categorical variable since it will be easier for analysis

#The once with empty values are replaced as Not Completed
feb_2018_enrollments_final$fully_participated_at[which(feb_2018_enrollments_final$fully_participated_at == "")] =
  "Not Completed"

#The once with Not Completed values are replaced as Completed
feb_2018_enrollments_final$fully_participated_at[which(feb_2018_enrollments_final$fully_participated_at != "Not Completed")] =
  "Completed"

table(feb_2018_enrollments_final$fully_participated_at)

#Cleaning Survey Response data
feb_2018_leaving_survey = data.frame(feb_2018_csv[[3]])

#omitting NA values
feb_2018_leaving_survey_final <- na.omit(feb_2018_leaving_survey[,-1])

#Making data in readable format
feb_2018_leaving_survey_final$leaving_reason[
  which(feb_2018_leaving_survey_final$leaving_reason == "The course wasnâ€™t what I expected")
] = "The course wasn't what I expected"

feb_2018_leaving_survey_final$leaving_reason[
  which(feb_2018_leaving_survey_final$leaving_reason == "I donâ€™t have enough time")
] = "I don't have enough time"

feb_2018_leaving_survey_final$leaving_reason[
  which(feb_2018_leaving_survey_final$leaving_reason == "The course wonâ€™t help me reach my goals")
] = "The course won't help me reach my goals"

feb_2018_leaving_survey_final

#merging leaving survey response data and enrollment data

#Using plyr package, we used join function to merge both the data
feb_2018_merged_data = join(feb_2018_enrollments_final,
                            feb_2018_leaving_survey_final,
                            by = "learner_id",
                            type = "left",
                            match = "all")

#Omitted rows with NA values
feb_2018_merged_data = na.omit(feb_2018_merged_data)

feb_2018_merged_data$intake = "February 2018"


colnames(feb_2018_merged_data)



#----------------------------------June Data ---------------------------------------------

#Getting csv files for june intake of 2018
june_2018_csv_list = list.files(path="data", pattern="^cyber-security-6_(.*)csv$", full.names = TRUE)

#Printing the list for sequence
(june_2018_csv_list)

#Getting all csv data in a list
june_2018_csv = lapply(june_2018_csv_list, read.csv)

#Since we want enrollments data and leaving survey responses, the position is 2 and 3 respective
june_2018_enrollments = data.frame(june_2018_csv[[2]])


#Pick required columns
june_2018_enrollments_final = june_2018_enrollments[,
                                                    c("learner_id",
                                                      "enrolled_at",
                                                      "role",
                                                      "fully_participated_at")]


#Applying filter for role as learner
june_2018_enrollments_final <- filter(june_2018_enrollments_final, role == "learner")

#Converting fully_participated_at as categorical variable since it will be easier for analysis

#The once with empty values are replaced as Not Completed
june_2018_enrollments_final$fully_participated_at[which(june_2018_enrollments_final$fully_participated_at == "")] =
  "Not Completed"

#The once with Not Completed values are replaced as Completed
june_2018_enrollments_final$fully_participated_at[which(june_2018_enrollments_final$fully_participated_at != "Not Completed")] =
  "Completed"

table(june_2018_enrollments_final$fully_participated_at)

#Cleaning Survey Response data
june_2018_leaving_survey = data.frame(june_2018_csv[[3]])

#omitting NA values
june_2018_leaving_survey_final <- na.omit(june_2018_leaving_survey[,-1])

#Making data in readable format
june_2018_leaving_survey_final$leaving_reason[
  which(june_2018_leaving_survey_final$leaving_reason == "The course wasnâ€™t what I expected")
] = "The course wasn't what I expected"

june_2018_leaving_survey_final$leaving_reason[
  which(june_2018_leaving_survey_final$leaving_reason == "I donâ€™t have enough time")
] = "I don't have enough time"

june_2018_leaving_survey_final$leaving_reason[
  which(june_2018_leaving_survey_final$leaving_reason == "The course wonâ€™t help me reach my goals")
] = "The course won't help me reach my goals"

june_2018_leaving_survey_final

#merging leaving survey response data and enrollment data

#Using plyr package, we used join function to merge both the data
june_2018_merged_data = join(june_2018_enrollments_final,
                             june_2018_leaving_survey_final,
                             by = "learner_id",
                             type = "left",
                             match = "all")

#Omitted rows with NA values
june_2018_merged_data = na.omit(june_2018_merged_data)


#Adding a key of intake to seperate data
june_2018_merged_data$intake = "June 2018"

colnames(june_2018_merged_data)


#----------------------------------Sept Data ---------------------------------------------

#Getting csv files for sept intake of 2018
sept_2018_csv_list = list.files(path="data", pattern="^cyber-security-7_(.*)csv$", full.names = TRUE)

#Printing the list for sequence
(sept_2018_csv_list)

#Getting all csv data in a list
sept_2018_csv = lapply(sept_2018_csv_list, read.csv)

#Since we want enrollments data and leaving survey responses, the position is 2 and 3 respective
sept_2018_enrollments = data.frame(sept_2018_csv[[2]])


#Pick required columns
sept_2018_enrollments_final = sept_2018_enrollments[,
                                                    c("learner_id",
                                                      "enrolled_at",
                                                      "role",
                                                      "fully_participated_at")]


#Applying filter for role as learner
sept_2018_enrollments_final <- filter(sept_2018_enrollments_final, role == "learner")

#Converting fully_participated_at as categorical variable since it will be easier for analysis

#The once with empty values are replaced as Not Completed
sept_2018_enrollments_final$fully_participated_at[which(sept_2018_enrollments_final$fully_participated_at == "")] =
  "Not Completed"

#The once with Not Completed values are replaced as Completed
sept_2018_enrollments_final$fully_participated_at[which(sept_2018_enrollments_final$fully_participated_at != "Not Completed")] =
  "Completed"

table(sept_2018_enrollments_final$fully_participated_at)

#Cleaning Survey Response data
sept_2018_leaving_survey = data.frame(sept_2018_csv[[3]])

#omitting NA values
sept_2018_leaving_survey_final <- na.omit(sept_2018_leaving_survey[,-1])

#Making data in readable format
sept_2018_leaving_survey_final$leaving_reason[
  which(sept_2018_leaving_survey_final$leaving_reason == "The course wasnâ€™t what I expected")
] = "The course wasn't what I expected"

sept_2018_leaving_survey_final$leaving_reason[
  which(sept_2018_leaving_survey_final$leaving_reason == "I donâ€™t have enough time")
] = "I don't have enough time"

sept_2018_leaving_survey_final$leaving_reason[
  which(sept_2018_leaving_survey_final$leaving_reason == "The course wonâ€™t help me reach my goals")
] = "The course won't help me reach my goals"

sept_2018_leaving_survey_final

#merging leaving survey response data and enrollment data

#Using plyr package, we used join function to merge both the data
sept_2018_merged_data = join(sept_2018_enrollments_final,
                             sept_2018_leaving_survey_final,
                             by = "learner_id",
                             type = "left",
                             match = "all")

#Omitted rows with NA values
sept_2018_merged_data = na.omit(sept_2018_merged_data)
sept_2018_merged_data$intake = "September 2018"

colnames(sept_2018_merged_data)

#------------------------------------Bringing All months data together ------------------------------------

all_months_final_data <- rbind(
  feb_2018_merged_data,
  june_2018_merged_data,
  sept_2018_merged_data
)
