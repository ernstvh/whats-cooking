# Set libPaths.
.libPaths("/home/ernst/.exploratory/R/3.3")

# Load required packages.
library(janitor)
library(lubridate)
library(hms)
library(jsonlite)
library(tidyr)
library(urltools)
library(stringr)
library(broom)
library(RcppRoll)
library(tibble)
library(dplyr)
library(exploratory)

# Data Analysis Steps
whats_json <- 
  exploratory::clean_data_frame(
  exploratory::toDataFrame(
  exploratory::convertFromJSON("/home/ernst/Projects/DataScience/RapidMiner/WhatsCooking/train.json")))

whats_all <- mutate(whats_json, cuisine=as.factor(cuisine))
cuisine_recipe <- whats_all[, c("id", "cuisine")]

split <- sort(sample(nrow(whats_all), nrow(whats_all)*.7))
whats_train <- whats_all[split,]
whats_test <- whats_all[-split,]

whats_train <- unnest(whats_train, ingredients)
train_tfidf <- do_tfidf(whats_train, id, ingredients)

whats_test <- unnest(whats_test, ingredients)
test_tfidf <- do_tfidf(whats_test, id, ingredients)

do_cosine_sim.kv(df=train_tfidf, subject=id, key = ingredients,value = tfidf) 