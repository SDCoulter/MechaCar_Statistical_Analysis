# MechaCar Statistical Analysis with R

## Challenge Overview

In this module we analysis car-based datasets using R and various statistical methods. Using automotive-based datasets we covered creating plots using ggplot2, formulating null and alternate hypotheses testing, and linear regression. We also briefly look at evaluating one- and two-sample t-tests, ANOVA (analysis of variance) models, and chi-squared tests. We also enter a discussion over A/B testing and determining the most appropriate statistical test for a given hypothesis and dataset.

## Linear Regression to Predict MPG

In Deliverable 1 we perform a multiple linear regression analysis on the `MechaCar MPG` dataset. We read in the CSV file, creating a data frame. We perform a linear regression analysis by using the `lm()` function. This function takes in a variable interpretation statement of the form `Y ~ A + B`, so we pass the dependent variable `mpg` as Y, and the other columns with the `+` operator, which is saved to a variable:

```{r}
regress <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = mecha)
```

We then wrap this in a `summary()` function to find the p-value and the r-squared value, shown in the console output screenshot below:

![Linear Regression to Predict MPG](images/01_d1_linear_regression_to_predict_mpg.png)



<!--

DETERMINE THE p-value and the r-squared value for the model.
`Multiple R-Squared: 0.7149`
`p-value = 5.35e-11` -- however, each variable has its own p-value too.

write a short summary using a screenshot of the output from the linear regression, and address the following questions:

Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?

the smallest ones right? -- (intercept), vehicle_length (2.60e-12), ground_clearance (5.21e-08) <---- check with notes

Is the slope of the linear model considered to be zero? Why or why not?

no right because using a multiple linear regression model we know y = m1x1 + ... and given there are values for m (are there? what would these be or where are they from) did we even get a line equation from the multiple anaylsis????

Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?

it predicts it at 71% - if that's good enough then yes, if not, then no???
more from notes obviously.

-->

## Context

This is the result of Module 15 of the University of Toronto School of Continuing Studies Data Analysis Bootcamp Course - **Statistics and R** - AutosRUs Automotive Manufacturing Analysis with R. Following the guidance of the module we end up pushing this selection of files to GitHub.
