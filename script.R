# The basics of R programming
# Explore
# Clean
# Manipulate
# Describe
# Visualize
# Analyse

# R studio
############
# The four quadrants
# How to get help when you need it
?mean
?ChickWeight

# Objects and functions
5 + 6

a <- 5
b <- 6

a + b

sum(a, b)

ages <- c(5, 6)
ages
sum(ages)

names<- c("John", "James")

friends <- data.frame(names, ages)
View(friends)
str(friends)

friends$ages
friends$names
sum(friends$ages)

friends[1,1]
friends[1, ]
friends[ ,1]

# Built in data sets to practice with
data()
if (!require(dplyr)) install.packages("dplyr")
library(dplyr)

starwarsDF <- as.data.frame(dplyr::starwars)
View(starwars)

# Installing and using packages
install.packages("tidyverse")
library(tidyverse)

starwars %>%
  filter(height > 150 & mass < 200) %>%
  mutate(height_in_meters = height/100) %>%
  select(height_in_meters, mass) %>%
  arrange(mass) %>%
  #View()
  plot()

# Explore 
##########

# Data structure and types of variables
View(msleep)

glimpse(msleep)

head(msleep)

class(msleep$name)

length (msleep)
length(msleep$name)

names(msleep)

unique(msleep$vore)

missing <- !complete.cases(msleep)

msleep[missing, ]

# Clean
##########
# Load the necessary libraries
library(dplyr)
library(tidyverse) # This loads dplyr and other useful packages

# Select specific columns
starwars %>% 
  select(name, height, mass)

# Select the first three columns
starwars %>% 
  select(1:3)

# View columns that end with "color"
starwars %>% 
  select(ends_with("color")) %>% 
  View()

# Changing variable order
starwars %>% 
  select(name, mass, height, everything()) %>% 
  View()

# Changing variable name
starwars %>% 
  rename(characters = name) %>% 
  head()

# Changing variable type
class(starwars$hair_color)
starwars$hair_color <-as.factor(starwars$hair_color)

class(starwars$hair_color)
  
starwars %>% 
  mutate(hair_color = as.character(hair_color)) %>% 
  glimpse()

# Changing factor levels
df <- starwars
df$sex <- as.factor(df$sex)

levels(df$sex)

df <- df %>% 
  mutate(sex = factor(sex,
                      levels = c("male", "female", "hermaphroditic", "none"
                                 )))
levels(df$sex)

# Filter rows
starwars %>% 
  select(mass, sex) %>% 
  filter(mass < 55 & sex == "male")

# Recode data
starwars %>% 
  select(sex) %>% 
  mutate(sex = recode(sex,
                      "male" = "man",
                      "female" = "woman"))

# Dealing with missing data
mean(starwars$height, na.rm = TRUE)

# Dealing with duplicates
Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)
friends <- data.frame(Names, Age)
friends

friends %>% 
  distinct()

distinct(friends)


# Manipulate
###########
# Create or change a variable (mutate)
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m)

# Conditional change (if_else)
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m) %>% 
  mutate(tallness = 
           if_else(height_m < 1,
                   "short",
                   "tall"))

# Reshape data with Pivot wider
install.packages("gapminder")
library(gapminder)
View(gapminder)

data <- select(gapminder, country, year, lifeExp)
View(data)

wide_data <- data %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

# Reshape data with Pivot longer
long_data <- wide_data %>% 
  pivot_longer(2:13,
               names_to = "year",
               values_to = "lifeExp")
View(long_data)

# Describe
#############
View(msleep)
