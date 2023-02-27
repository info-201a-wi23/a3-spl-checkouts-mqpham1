# Load libraries
library(dplyr)
library(tidyverse)

# Load data
checkout_data <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv")

# Highest number of checkouts within a month
max_checkout <- checkout_data %>%
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>%
  select(Checkouts) %>%
  pull()

# Title with highest number of checkouts in a month
title_checkout <- checkout_data %>%
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>%
  select(Title) %>%
  pull()

# Month with highest checkouts
month_checkouts <- checkout_data %>%
  filter(CheckoutYear != "2023") %>%
  group_by(CheckoutMonth) %>%
  summarize(Checkouts = n()) %>%
  filter(Checkouts == max(Checkouts)) %>%
  select(CheckoutMonth) %>%
  pull()

# Number of highest checkouts per month
max_month_checkouts <- checkout_data %>%
  filter(CheckoutYear != "2023") %>%
  group_by(CheckoutMonth) %>%
  summarize(Checkouts = n()) %>%
  filter(Checkouts == max(Checkouts)) %>%
  select(Checkouts) %>%
  pull()

# Total checkouts of audiobooks
total_audio <- checkout_data %>%
  group_by(MaterialType) %>%
  summarize(Checkouts = n()) %>%
  filter(MaterialType == "AUDIOBOOK") %>%
  select(Checkouts) %>%
  pull()
