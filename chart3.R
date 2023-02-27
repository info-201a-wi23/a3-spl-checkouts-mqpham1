# Load libraries
library(dplyr)
library(tidyverse)
library(ggplot2)

# Load data
checkout_data <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv")

# Pepare for plotting
checkouts_by_month <- checkout_data %>%
  filter(CheckoutYear != "2023") %>%
  group_by(CheckoutMonth) %>%
  summarize(Checkouts = n())

checkouts_by_month <- checkouts_by_month %>% mutate(Month = month.name[CheckoutMonth])

checkouts_by_month$Month <- factor(checkouts_by_month$Month, levels=month.name)

# Bar Chart
ggplot(checkouts_by_month, aes(x = Month, y = Checkouts, fill = "#FE6F5E")) +
  geom_bar(stat = "identity") + 
  labs(title = "Total Checkouts By Month 2017-2022", x = "Month", y = "Number of Checkouts") +
  theme(axis.text.x = element_text(angle = 45)) +
  theme(legend.position = "none")

  