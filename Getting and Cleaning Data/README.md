# Codebook
This document describes the data and code needed to product the tidy data files for Coursera's Data Science Spcification - Getting and Cleaning Data - Week 4 Project
## Necessary Libraries
tidyverse, read.table



## Data Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Data Description
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## R Code description
Seven main steps:

1. Load libraries
2. Download data from the data source to local machine
3. Load necessary data into R
4. Merge all training and test sets into one set
5. Limit data to fields that include descriptions, mean, and standard deviation
6. Create aggreagated table that takes the average of each measurement field
7. Write tidy data set and aggregated tidy data set to local machine


