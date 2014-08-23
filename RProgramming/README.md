---
title: "RProgramming"
author: "Marc"
date: "Friday, August 22, 2014"
output: html_document
---
This folder contains the work that I have done as part of Johns Hopkins R Programming course <https://class.coursera.org/rprog-006>.

##Swirl
One of the assignments for the class is to do the swirl tutorial.  Technically this is a an extra credit assignment for an extra 6 points.  More importantly it is a good intro for using R.  You can use the tutorial use the steps below
```
install.packages("swirl")
library(swirl)
swirl()
```
One you run swirl you will be prompted to choose a course.  R Programming is what you will use for this class but it is a good introduction to R in an interactive environment.  There are other courses that you can install as well.
##Programming Assignment 1: Air Pollution
This assignment uses pollution monitoring data.  There are three different files that are part of this assignment.

- pollutantmean.r - Calculate the mean of a specific polutant
- complete.r - Find the total number of observed cases where all pollutants were measured
- corr.r - Analyze  the correlation between sulfate and nitrate
Uses the correlation method as seen below
```
cor()
```

##Programming Assignment 2
The main goal of this project is to practice writing an R function that uses a cache to speed up data analysis.  Part of this assignment was to upload it to a GitHub repository so you can find my file and the markdown document file in the repository (https://github.com/marccarmen/ProgrammingAssignment2)

##Programming Assignment 3: Hospital Quality
This assignment uses hospital review data.  There are several files that are part of this project

- best.r - Given a state and an outcome (mortality rate for a disease) find the best hospital in the state.
- rankhospital.r - Given a state, an outcome, and a rank find the hopsital with that particular rank.  In other words find all the hospitals for a state and order them based on the outcome.  Then find the hopsital with the specific rank.
- rankall.r - Given an outcome and a rank find the hospital in each state with that rank and otucome.

