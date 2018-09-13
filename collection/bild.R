# load functions
source("./collection/helper/parse_nexis.R")

# define dates
begin <- as.Date("2018-03-15")
end <- as.Date("2018-05-08")

# define date sequence for given time frame
timeframe <- seq(from = begin, 
                 to = end, 
                 by = 1)

## BILD ONLINE ----

# define empty data frame
bild_online <- data.frame(date = timeframe,
                          stringsAsFactors = F)

# energy
energy <- parse_nexis("./data/nexis/bild_online_energy.csv",
                      column_name = "energy")

# health
health <- parse_nexis("./data/nexis/bild_online_health.csv",
                      "health")

# immigration
immigration <- parse_nexis("./data/nexis/bild_online_immigration.csv",
                           "immigration")

# trade
trade <- parse_nexis("./data/nexis/bild_online_trade.csv",
                     "trade")

# join data frames
bild_online <- bild_online %>% 
  left_join(energy, by = c("date" = "date_parsed")) %>%
  left_join(health, by = c("date" = "date_parsed")) %>%
  left_join(immigration, by = c("date" = "date_parsed")) %>%
  left_join(trade, by = c("date" = "date_parsed"))

# fill NAs with 0
bild_online[is.na(bild_online)] <- 0

# save data frame
saveRDS(bild_online, "./data/bild_online.rds")

## BILD OFFLINE ----

# define empty data frame
bild_offline <- data.frame(date = timeframe,
                           stringsAsFactors = F)

# energy
energy <- parse_nexis("./data/nexis/bild_offline_energy.csv",
                      column_name = "energy")

# health
health <- parse_nexis("./data/nexis/bild_offline_health.csv",
                      "health")

# immigration
immigration <- parse_nexis("./data/nexis/bild_offline_immigration.csv",
                           "immigration")

# trade
trade <- parse_nexis("./data/nexis/bild_offline_trade.csv",
                     "trade")

# join data frames
bild_offline <- bild_offline %>% 
  left_join(energy, by = c("date" = "date_parsed")) %>%
  left_join(health, by = c("date" = "date_parsed")) %>%
  left_join(immigration, by = c("date" = "date_parsed")) %>%
  left_join(trade, by = c("date" = "date_parsed"))

# fill NAs with 0
bild_offline[is.na(bild_offline)] <- 0

# save data frame
saveRDS(bild_offline, "./data/bild_offline.rds")