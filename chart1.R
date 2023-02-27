# Load libraries
library(dplyr)
library(tidyverse)
library(ggplot2)

# Load data
checkout_data <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv")

# Pepare for plotting
checkout_materials <- checkout_data %>%
  group_by(CheckoutYear) %>%
  filter(MaterialType == "AUDIOBOOK") %>%
  filter(CheckoutYear != "2023") %>%
  summarize(Audio_Checkouts = sum(Checkouts))

checkout_book <- checkout_data %>%
  group_by(CheckoutYear) %>%
  filter(MaterialType == "BOOK") %>%
  summarize(Book_Checkouts = sum(Checkouts))

checkout_materials <- merge(checkout_materials, checkout_book, by = "CheckoutYear")

checkout_ebook <- checkout_data %>%
  group_by(CheckoutYear) %>%
  filter(MaterialType == "EBOOK") %>%
  summarize(Ebook_Checkouts = sum(Checkouts))

checkout_materials <- merge(checkout_materials, checkout_ebook, by = "CheckoutYear")

# Line graph
df <- gather(checkout_materials, key = material, value = Rate, 
             c("Audio_Checkouts", "Book_Checkouts", "Ebook_Checkouts"))

ggplot(df, aes(x = CheckoutYear, y = Rate, group = material, color = material)) +
  geom_line() + 
  labs(title = "Checkouts by Material From 2017-2022", x = "Checkout Year", y = "Number of Checkouts", color = "Material Type") +
  scale_color_discrete(breaks = c("Audio_Checkouts", "Book_Checkouts", "Ebook_Checkouts"), labels = c("Audio Books", "Books", "Ebooks"))

