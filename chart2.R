# Load libraries
library(dplyr)
library(tidyverse)
library(ggplot2)

options(dplyr.summarise.inform = FALSE)

# Load data
checkout_data <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv")

# Pepare for plotting
checkout_hm <- checkout_data %>%
  filter(Creator == "Haruki Murakami") %>%
  filter(CheckoutYear != "2023") %>%
  filter(!grepl("unabridged", Title, ignore.case = TRUE)) %>%
  group_by(CheckoutYear, Title) %>%
  summarize(Checkouts = sum(Checkouts)) %>%
  filter(Checkouts >= 50)

# Line graph
ggplot(checkout_hm, aes(x = CheckoutYear, y = Checkouts, group = Title, color = Title)) +
  geom_line() + 
  labs(title = "Haruki Murakami Checkouts From 2017-2022", x = "Checkout Year", y = "Number of Checkouts", color = "Title")
