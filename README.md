Task 1 — Data Audit & Anomaly Identification
Load the dataset into the R environment. Execute the unique() function against both the Operator_Name and Machine columns. 
Examine the console output with particular attention to quotation mark boundaries, as this will reveal the presence of invisible 
trailing whitespace characters that constitute the primary string integrity issue.

Solution: For Details refer to [Assignment_2.R](https://github.com/krishlibran/Project-2-Legacy-Data-Cleaning-Protocol-Data-Rescue-Initiative/blob/main/Assignment_2.R#L1-L9)

Task 2 — String Standardisation & Normalisation
Utilising the mutate() function in conjunction with the stringr package, perform the following standardisation operations:

• Apply str_trim() to excise all invisible whitespace from operator name fields.

• Apply str_to_title() to enforce consistent title-case capitalisation across all operator names.

• Convert all values in the Machine column to uppercase format.

• Standardise non-uniform machine name variants such as CNC-LATHE and MILLING MACH into their approved canonical formats.

Solution: For Details refer to [Assignment_2.R](https://github.com/krishlibran/Project-2-Legacy-Data-Cleaning-Protocol-Data-Rescue-Initiative/blob/main/Assignment_2.R#L11-L18)

Task 3 — Data Imputation via Contextual Inference
You are expressly prohibited from deleting rows containing missing data. Instead, you shall employ mutate() combined with ifelse() to perform contextual imputation based upon the following established factory operational rules:

• Where the Machine field is null and the operator is identified as "Vikram" — who is exclusively assigned to the Drill Press — the missing value shall be imputed as "DRILL_PRESS".

• Where the Shift field is null and the operator is identified as "Rahul" — who works exclusively on the Night Shift — the missing value shall be imputed as "Night".

Solution: Below is the table showning the Log_Date columns from Raw_Data and Clean_Data
| Raw_Data Operator | Raw_Data Shift | Raw_Data Machine | Clean_Data Operator | Clean_Data Shift | Clean_Data Machine |
|-------------|-----------|-------------|----------------|-------------|---------------|
| Vikram | Night | NA | Vikram | Night | DRILL_PRESS |
| VIKRAM | Night | NA | Vikram | Night | DRILL_PRESS |
| Rahul | NA | CNC_Lathe | Rahul | Night | CNC_LATHE |
| Rahul | NA | Drill_Press | Rahul | Night | DRILL_PRESS |

For Details refer to [Assignment_2.R](https://github.com/krishlibran/Project-2-Legacy-Data-Cleaning-Protocol-Data-Rescue-Initiative/blob/main/Assignment_2.R#L22-L24)

Task 4 — Rectification of Logically Impossible Values
Identify all records wherein the Downtime_Minutes value is less than zero. Such values are logically impossible and cannot be deduced from available contextual information. Replace these specific erroneous values with NA to accurately represent their unknown status.

Solution: Below is the table showning the Log_Date columns from Raw_Data and Clean_Data
| Log_ID | Raw_Data Downtime_Minutes | Clean_Data Downtime_Minutes |
|-----------|----------------------|------------------------|
| 150 | -15 | NA |
| 31 | -11 | NA |
| 56 | -7 | NA |
| 105 | 0 | 0 |
| 130 | 3 | 3 |

For details, refer to [Assignment_2.R](https://github.com/krishlibran/Project-2-Legacy-Data-Cleaning-Protocol-Data-Rescue-Initiative/blob/main/Assignment_2.R#L25)

Task 5 — Date Format Standardisation
Load the lubridate package and apply the parse_date_time() function to coerce the Log_Date column into a single standardised format. The function must be configured to recognise and process all three date formats present in the raw data: YYYY-MM-DD, DD/MM/YYYY, and DD.MM.YYYY.

Solution: Below is the table showning the Log_Date columns from Raw_Data and Clean_Data
| Record ID | Raw_Data Log_Date | Clean_Data Log_Date |
|-----------|----------|----------|
| 6 | 2026-06-18 | 2026-06-18 |
| 7 | 08.06.2026 | 2026-06-08 |
| 8 | 2026-06-11 | 2026-06-11 |
| 9 | 15/06/2026 | 2026-06-15 |

For details, refer to [Assignment_2.R](https://github.com/krishlibran/Project-2-Legacy-Data-Cleaning-Protocol-Data-Rescue-Initiative/blob/main/Assignment_2.R#L26)

Task 6 — Feature Engineering: Downtime Severity Classification
Create a new derived column designated Downtime_Severity by applying the case_when() function in accordance with the following classification schema:
| Condition | Assigned Classification |
|-----------|-------------------------|
| Downtime_Minutes > 60 | Critical |
| 30 < Downtime_Minutes ≤ 60 | Warning |
| Downtime_Minutes ≤ 30 | Acceptable |
| Value is NA (missing) | Unknown |

Solution: 
| Machine | Downtime_Minutes | Classification |
|----------|------------------|----------------|
| DRILL_PRESS | 19 | Acceptable |
| STAMPING_PRESS | NA | Unknown |
| STAMPING_PRESS | 54 | Warning |
| STAMPING_PRESS | 62 | Critical |
| MILLING_MACHINE | 39 | Warning |

For details, refer to [Assignment_2.R]

Task 7 — Export of Cleaned Dataset
Upon successful completion of all preceding tasks, export the fully cleaned and processed data frame to a CSV file designated jv_clean_logs.csv. Ensure that the exported file faithfully reflects all transformations applied during Tasks 1 through 6.

Solution: We have exported our clean data into a new csv file. For details refer to [Assignment_2.R]
