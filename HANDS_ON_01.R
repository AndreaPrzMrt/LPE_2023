# SCRIPT + STUDENT INFO ---------------------------------------------------
# NOMBRE: ANDREA PÉREZ MARTÍN
# EXP: 22123112
# TEMA: HANDS_ON_01


# LOADING LIBS ------------------------------------------------------------
install.packages("tidyverse", "janitor")
library("dplyr", "janitor")

# LOADING DATA ------------------------------------------------------------
exp_22123112 <- jsonlite::fromJSON("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")


# SHORTCUTS ---------------------------------------------------------------

# CLEAN CONSOLE = CTRL + l
# %>% pipe operator = SHIFT + CTRL + M
# CTRL + ENTER = run line
# assign value = alt + -


# GIT COMMANDS ------------------------------------------------------------

# pwd = current location
# git status = info about a repo
# git commit = Add a comment
# git add . = Add the current dir to the entire repo
# git push -u origin main = send to the remote repo (Github)


# CLI COMMANDS ------------------------------------------------------------

# pwd = shows the current dir
# ls = list terminal 
# mkdir = create a dir
# cd = change dir


# BASIC INSTRUCTIONS ------------------------------------------------------

isa <- 8 # assigning values


# TIDYVERSE COMMANDS ------------------------------------------------------

exp_22123112 %>% glimpse() %>% View()


# 27 SEP 2023 -------------------------------------------------------------

str(exp_22123112) # get data type
df <- exp_22123112$ListaEESSPrecio # get readable data
glimpse(df)
df %>% janitor::clean_names() %>% glimpse()
