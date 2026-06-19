library(dplyr)
library(stringr)
library(lubridate)

production <- read.csv("D:/R_and_EXCEL_PROJECTS/Assignment 2/JV employee logs May 2026.csv")
rawdata <- production

unique(rawdata$Operator_Name)
unique(rawdata$Machine)

# Task 2
clean_data <- mutate(rawdata, 
                     Operator_Name = str_trim(Operator_Name),
                     Operator_Name = str_to_title(Operator_Name),
                     Machine = str_to_upper(Machine),
                     Machine = str_replace(Machine, "CNC-LATHE", "CNC_LATHE"),
                     Machine = str_replace(Machine, "MILLING MACH", "MILLING_MACHINE"),
                     Machine = str_replace(Machine, "DRILLPRESS", "DRILL_PRESS"))

# Task 3

impute_data <- mutate(clean_data,
                      Machine = ifelse(is.na(clean_data$Machine), ifelse(clean_data$Operator_Name == "Vikram", "DRILL_PRESS", clean_data$Machine), clean_data$Machine),
                      Shift = ifelse(is.na(Shift), ifelse(Operator_Name == "Rahul", "Night", Shift), Shift),
                      Downtime_Minutes = ifelse(Downtime_Minutes <0, NA, Downtime_Minutes), #Task 4
                      Log_Date = parse_date_time(Log_Date, c("ymd", "dmy")), # TASK 5
                      Downtime_Severity = case_when(is.na(Downtime_Minutes) ~ "Unknown",
                                                    Downtime_Minutes > 60 ~ "Critical",
                                                    Downtime_Minutes <= 60 & Downtime_Minutes > 30 ~ "Warning",
                                                    TRUE ~ "Acceptable")) # Task 6

# Task 7
write.csv(impute_data, "jv_clean_logs.csv", row.names = FALSE)
