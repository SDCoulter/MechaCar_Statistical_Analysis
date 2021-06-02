# MechaCar Statistical Analysis with R

## Module and Challenge Overview

In this module we analysis car-based datasets using R and various statistical methods. Using automotive-based datasets we covered creating plots using ggplot2, formulating null and alternate hypotheses testing, and linear regression. We also briefly look at evaluating one- and two-sample t-tests, ANOVA (analysis of variance) models, and chi-squared tests. We also enter a discussion over A/B testing and determining the most appropriate statistical test for a given hypothesis and dataset.

<!-- Include overview of the challenge here. -->

## Linear Regression to Predict MPG

In Deliverable 1 we perform a multiple linear regression analysis on the `MechaCar MPG` dataset. We read in the CSV file, creating a data frame. We perform a linear regression analysis by using the `lm()` function. This function takes in a variable interpretation statement of the form `Y ~ A + B`, so we pass the dependent variable `mpg` as Y, and the other columns with the `+` operator, which is saved to a variable:

```r
regress <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha)
```

We then wrap this in a `summary()` function to find the p-value and the r-squared value, shown in the console output screenshot below:

![Linear Regression to Predict MPG](images/01_d1_linear_regression_to_predict_mpg.png)

From the screenshot we can see the whole model has a **p-value** of `5.35e-11` (implying a significant result), and an **r-squared** value of `0.7149`.

***Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?***

From the individual p-values shown in the screenshot for each variable (`Pr(>|t|)`) we can see that, as well as the intercept, `vehicle_length` with a p-value of `2.60e-12` and `ground_clearance` with a p-value of `5.21e-08` provide a non-random amount of variable to the `mpg` values in the dataset. This means, with low p-values, `vehicle_length` and `ground_clearance` have a statistically significant impact on the `mpg` values for the dataset. The intercept having a low p-value (`5.08e-08`) means that it explains a significant amount of variability in the dependent variable when all independent variables are zero. *Due to this, we may need to look at scaling or transforming the data to help improve the predictive power of the model.*

***Is the slope of the linear model considered to be zero? Why or why not?***

When dealing with multiple linear regression we set our **null hypothesis** to state: H<sub>0</sub> – the slope of the linear model is zero, or m = 0. With a p-value of `5.35e-11` and a standard significance level of `0.05` we can state there is sufficient evidence to reject the null hypothesis. Meaning the slope of our linear model is **non-zero**.

***Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?***

With an r-squared value of `0.7149` we can say our model is statistically significant and predicts the `mpg` 70% of the time. This value falls into a higher-correlation subgroup of r-squared values so we could say the model predicts somewhat strongly. In a real-world setting we would want to decide on an acceptable r-squared value before performing analysis to remove bias. We are not given any boundaries for this value in the assignment so we can only go off our own intuition, which is to say, yes, this model does predict `mpg` fairly effectively, but leaves a lot of room for growth.

## Summary Statistics on Suspension Coils

In Deliverable 2 we read in the `Suspension_Coils` dataset and create a second data frame. We create a total summary of this dataset using the `summarize()` function, chaining the functions with the pipe operator `%>%`. In our summary data frame, we want to find out the Mean, Median, Variance and Standard Deviation of the data, so we pass in the corresponding functions, assigning the values to columns of the same names:

```r
total_summary <- coils %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
```
 Which produces the new `total_summary` data frame:

![Suspension Coils Dataset Total Summary](images/02_d2_total_summary.png)

We also want to view similar summary statistics but grouped into lot numbers. The `Manufacturing_Lot` column of the dataset contains the different categories of Lot - `Lot1`, `Lot2`, and `Lot3`. So, we must first group by this column before running the same `summarize()` function.

```r
lot_summary <- coils %>% group_by(Manufacturing_Lot) %>%
  summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
```

Producing the `lot_summary` data frame:

![Suspension Coils Dataset Group by Lot Number Summary](images/03_d2_lot_summary.png)

***The design specifications for the MechaCar suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per square inch. Does the current manufacturing data meet this design specification for all manufacturing lots in total and each lot individually? Why or why not?***

From the `total_summary` data frame we can see that with **all the suspension coils combined, the variance falls in the limits of the design specification** - `62.29356` being less than the required `100`. However, when separating the coils and grouping them into their `Manufacturing_Lot`'s we see that `Lot3` does not. `Lot1` and `Lot2`, have good variance values, easily within the design specification, `0.9795918` and `7.4693878` respectively. `Lot3` though has a variance of `170.2861224` which is far from the design specification, meaning `Lot3` **exceeds 100 pounds per square inch in variance**.

## T-Tests on Suspension Coils

In Deliverable 3 we continue our analysis on the `Suspension_Coils` dataset, by performing Student's t-tests on the PSI column. First, we remind ourselves of the hypotheses being tested by this analysis:

- H<sub>0</sub> - there is **no statistical difference** between the observed sample mean and its presumed population mean.
- H<sub>a</sub> – there is **a statistical difference** between the observed sample mean and its presumed population mean.

 Then we use the `t.test()` function on the whole dataset (the full PSI column), passing in the population mean, mu, as `1500` (given in the challenge).

```r
t.test(coils$PSI, mu = 1500)
```

Which produces our t-test console output:

![T-Test on all Coils (PSI)](images/04_d3_test_total.png)

Here we can see our p-value is `0.06028` which is above our standard `0.05` significance level. This means we do not reject the null hypothesis - the evidence shows there is **no statistically significant difference** between the observed sample mean and the population mean. *Even though the p-value is close to our significance level we still cannot reject the null hypothesis, and we must say there is no statistical difference between the observed sample mean and the population mean.*

We perform similar t-tests on the PSI column, but this time grouping by `Manufacturing_Lot`. We do this by creating subsets of the dataset with the `subset()` function, and only pass PSI values in that meet the `Lot` criteria.

```r
t.test(subset(coils, Manufacturing_Lot == 'Lot1')$PSI, mu = 1500)
t.test(subset(coils, Manufacturing_Lot == 'Lot2')$PSI, mu = 1500)
t.test(subset(coils, Manufacturing_Lot == 'Lot3')$PSI, mu = 1500)
```

We run each test and produce an output for each one in the console:

![T-Test on Coils Subset by Manufacturing_Lot](images/05_d3_test_lots.png)

Each test produces a p-value that we can interpret and reject or fail to reject the null hypothesis with.

- `Lot1` has a p-value of `1` - this means that the observed mean of the subset and the population mean are identical. We of course cannot reject the null hypothesis, there is **no statistically significant difference** between the sample mean and population mean - *both are 1500.*
- `Lot2` has a p-value of `0.6072` - again we see a p-value above our `0.05` significance level. We follow on from the previous determinations in not rejecting the null hypothesis and saying there is **no statistically significant difference** between the sample mean and population mean.
- `Lot3` has a p-value of `0.04168` - here we see a p-value below the `0.05` significance level, so unlike the other two `Lot`'s we ***do*** reject the null hypothesis. This means there **is a statistically significant difference** between the sample mean and the population mean. We expect this already from the analyses performed in Deliverable 1 and 2, however it is always good to compare fully and perform rigorous testing before making claims about data.

## Study Design: MechaCar vs Competition

In Deliverable 4 we design our own analysis to compare some of the most important factors in buying a car, the safety, the type/class, and the fuel efficiency. We want to ask the question: **Is there any statistical difference in the fuel efficiency of a vehicle based on safety rating and vehicle class?**

**What metric or metrics are you going to test?**

We are going to test the safety rating and vehicle class metrics to see if and how they statistically affect the fuel efficiency of a vehicle. The dependent variable is the fuel efficiency, which is numerical and continuous. The independent variables are the safety rating and the vehicle class, which are categorical. (*We assume the dependent variable is normally distributed, and the variance among each categorical group should be similar.*)

**What is the null hypothesis or alternative hypothesis?**

We set up our hypotheses to be:

- H<sub>0</sub> - the means of all the groups are equal - μ1 = μ2 = … = μn.
-	H<sub>a</sub> – at least one of the means is different from all other groups.

Meaning we are comparing the means of the independent variable's fuel efficiency values, where they are grouped by vehicle class and safety ratings. If we reject the null hypothesis we are saying that at least one of these groups has a different mean, we would be saying there is a significant difference in the mean fuel efficiency in at least one of these groups.

**What statistical test would you use to test the hypothesis? And why?**

With a numerical, continuous dependent variable, and two categorical independent variables we would choose to do a two-way ANOVA test. This test asks the questions, is there a statistical difference between the distribution means from multiple samples? We choose this test simply because the data types make it the prime choice to learn more about the dependent variable.

**What data is needed to run the statistical test?**

To run this test we would need information about vehicle classes, safety ratings, and the known fuel efficiencies. We would be fools to think we could gather anywhere close to the a whole population of data on vehicles, given the sheer number of them. This means we look at taking a sample (as fairly as we can) that contains this data. We would then likely need to clean and sort it, pulling out the relevant information and removing any nonsensical data, before running our analysis.

We would also need to inspect the classes and safety ratings to make sure the groupings and the data are distributed fairly. Since these are categorical variables we would want to make sure they're standardized so they all fall into expected groups, and that there's a similar number of each of them.

## Context

This is the result of Module 15 of the University of Toronto School of Continuing Studies Data Analysis Bootcamp Course - **Statistics and R** - AutosRUs Automotive Manufacturing Analysis with R. Following the guidance of the module we end up pushing this selection of files to GitHub.
