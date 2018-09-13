# load packages
library(dplyr)

# load functions
source("./collection/helper/get_faz.R")

# define dates
begin <- as.Date("2018-03-15")
end <- as.Date("2018-05-08")

# define date sequence for given time frame
timeframe <- seq(from = begin, 
                 to = end, 
                 by = 1)

# define empty dfs
faz_online <- data.frame(date = timeframe,
                         stringsAsFactors = F)

faz_offline <- data.frame(date = timeframe,
                          stringsAsFactors = F)

## HEALTH ----
keywords <- c("Pflege",
              "Gesundheitssystem",
              "Krankenversicherung",
              "Privatversicherung",
              "Kassenpatienten",
              "Landarzt",
              "Hebame")
health <- loop_faz_archive(paste(keywords, collapse = " OR "),
                           faz_online,
                           faz_offline,
                           "health")

## ENERGY ----
keywords <- c("Atomkraft",
              "Erneuerbare",
              "Tihange",
              "Atomausstieg",
              "Energiewende",
              "Kohlekraft",
              "Kohleausstieg")
energy <- loop_faz_archive(paste(keywords, collapse = " OR "),
                           faz_online,
                           faz_offline,
                           "energy")

## IMMIGRATION ----

# define key words
keywords <- c("Flüchtlinge", 
              "Grenzkontrolle", 
              "Asyl")
immigration <- loop_faz_archive(paste(keywords, collapse = " OR "),
                                faz_online,
                                faz_offline,
                                "immigration")

## FOREIGN TRADE ----

# define key words
keywords <- c("WTO",
              "Handelskrieg",
              "CETA",
              "TTIP",
              "Handelsdefizit",
              "Handelsüberschuss",
              "Exportweltmeister",
              "Zölle",
              "Strafzölle")
trade <- loop_faz_archive(paste(keywords, collapse = " OR "),
                          faz_online,
                          faz_offline,
                          "trade")

# join data frames
faz_online <- faz_online %>% 
  left_join(health$online, by = c("date" = "date")) %>% 
  left_join(energy$online, by = c("date" = "date")) %>% 
  left_join(immigration$online, by = c("date" = "date")) %>% 
  left_join(trade$online, by = c("date" = "date"))

faz_offline <- faz_offline %>% 
  left_join(health$offline, by = c("date" = "date")) %>% 
  left_join(energy$offline, by = c("date" = "date")) %>% 
  left_join(immigration$offline, by = c("date" = "date")) %>% 
  left_join(trade$offline, by = c("date" = "date"))

# save dataframes
saveRDS(faz_online, "./data/faz_online.rds")
saveRDS(faz_offline, "./data/faz_offline.rds")
