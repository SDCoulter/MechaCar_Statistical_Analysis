# Load dplyr package.
library(dplyr)

# Import and read the MechaCar_mpg.csv dataset.
mecha <- read.csv('MechaCar_mpg.csv', header=T, stringsAsFactors = F)

# Perform linear regression analysis.
regress <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha)

# Get summary statistics.
summary(regress)