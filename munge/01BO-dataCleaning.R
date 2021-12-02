# preprocessing script.

feb_2018_csv_list = list.files(path="data", pattern="^cyber-security-5_(.*)csv$", full.names = TRUE)

feb_2018_csv_list

data_csv = lapply(feb_2018_csv_list, read.csv)

summary(data_csv[[1]])


for (i in 1:length(feb_2018_csv_list)) assign(feb_2018_csv_list[i], read.csv(feb_2018_csv_list[i]))
