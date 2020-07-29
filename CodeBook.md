---
title: "CodeBook.md"
author: "Ivan Seliukov"
date: "28 07 2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

The run_analysys.R script is based on UCI HAR Dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
There are 7 parts divided by comments:
1. This part downloads the data from the source. Then it defines separate documents into variables (features, activities, ... etc)
2. This part merges data into test and training variables using rbind and cbind as it written in instructions.
3. In this part I extracted standard deviation and mean from the merged data (point 2).
4. In this part I changed names of rows into activities names and renamed to proper names.
5. In this part there is independent data set with the average of each variable for each activity and each subject.
6. Testing the output. 