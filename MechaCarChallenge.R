### -- DELIVERABLE 1 - Linear Regression to Predict MPG -- ###

# Load dplyr package.
library(dplyr)

# Import and read the MechaCar_mpg.csv dataset.
mecha <- read.csv('MechaCar_mpg.csv', header = T, stringsAsFactors = F)

# Perform linear regression analysis.
regress <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha)

# Get summary statistics.
summary(regress)



### -- DELIVERABLE 2 - Summary Statistics on Suspension Coils -- ###

# Import and read the Suspension_Coil.csv dataset.
coils <- read.csv('Suspension_Coil.csv', header = T, stringsAsFactors = F)

# Create total summary data frame.
total_summary <- coils %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))

# Create summary data frame grouped by Manufacturing_Lot column.
lot_summary <- coils %>% group_by(Manufacturing_Lot) %>%
  summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))



### -- DELIVERABLE 3 - T-Tests on Suspension Coils -- ###

# t-test to compare full sample mean to population mean of 1500.
t.test(coils$PSI, mu = 1500)

# 3 t-test - 1 for each Manufacturing Lot.
t.test(subset(coils, Manufacturing_Lot == 'Lot1')$PSI, mu = 1500)
t.test(subset(coils, Manufacturing_Lot == 'Lot2')$PSI, mu = 1500)
t.test(subset(coils, Manufacturing_Lot == 'Lot3')$PSI, mu = 1500)
