# SCRIPT + STUDENT INFO ---------------------------------------------------
# NOMBRE: ANDREA PÉREZ MARTÍN
# EXP: 22123112
# TEMA: HANDS_ON_01


# LOADING LIBS ------------------------------------------------------------
install.packages("tidyverse", "janitor", "readr")
install.packages("leaflet")
library(tidyverse)
library(janitor)
library(leaflet)
library(readr)
library(readxl)

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


# WORKING W PIPES (OPT. MODE) ---------------------------------------------

clean_data <- df %>% janitor::clean_names() %>% glimpse()

clean_data_2 <- df %>% readr::type_convert(locale = readr::locale(decimal_mark=",")) %>% clean_names() %>% as_tibble()
clean_data_2 %>% glimpse()


# DEALING W DATA ----------------------------------------------------------

villa_boa_gas <- clean_data_2 %>% select(precio_gasoleo_a, rotulo, direccion, localidad) %>% 
  filter(localidad=="VILLAVICIOSA DE ODON" | localidad== "BOADILLA DEL MONTE") %>% 
  arrange(precio_gasoleo_a) %>% View()


# STORING DATA ------------------------------------------------------------

write_excel_csv2(villa_boa_gas, "informe_madrid.xlsx")


# WORKING W REPORTS -------------------------------------------------------

gas_mad_1_55 <- clean_data_2 %>% select(precio_gasoleo_a, rotulo, direccion, localidad, provincia, latitud, longitud_wgs84) %>% 
  filter(provincia == "MADRID" & precio_gasoleo_a<1.55) %>% arrange(desc(precio_gasoleo_a))

gas_mad_1_55 %>% leaflet() %>% addTiles() %>% addCircleMarkers(lat = ~latitud, lng = ~longitud_wgs84, popup=~rotulo, label=~precio_gasoleo_a)

# CLASE 18 OCT ------------------------------------------------------------

gas_mad_ballenoil <- clean_data_2 %>% select(precio_gasoleo_a, rotulo, direccion, localidad, provincia) %>% 
  filter(provincia == "MADRID" & rotulo == "BALLENOIL") %>% arrange(precio_gasoleo_a) %>% View()

gas_mad_mean_rotulo <- clean_data_2 %>% group_by(rotulo) %>% summarise(mean(precio_gasoleo_a)) %>% View()


# DEALING W COLS ----------------------------------------------------------

clean_data_2 %>% mutate(low_cost = !rotulo %in% c("REPSOL","CEPSA","Q8","BP","SHELL","CAMPSA","GALP")) %>% View()


# JOIN CCAA ---------------------------------------------------------------

ccaa <- read_excel("codccaa_OFFCIAL.xls", skip=1)
merged_df <- clean_data_2 %>% 
  left_join(ccaa, by = c("idccaa" = "CODIGO")) %>% 
  rename("comunidad_autonoma" = LITERAL) %>% view()

# cambiar 07 por 08

copied_df <- merged_df

copied_df$`comunidad_autonoma`[copied_df$idccaa == "07"] <- "Castilla-La Mancha"
copied_df$`comunidad_autonoma`[copied_df$idccaa == "08"] <- "Castilla y León"

copied_df %>% View()
