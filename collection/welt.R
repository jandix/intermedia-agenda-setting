# load functions
source("./collection/helper/parse_nexis.R")

# define dates
begin <- as.Date("2018-03-15")
end <- as.Date("2018-05-08")

# define date sequence for given time frame
timeframe <- seq(from = begin, 
                 to = end, 
                 by = 1)

## WELT ONLINE ----

# define empty data frame
welt_online <- data.frame(date = timeframe,
                          stringsAsFactors = F)

# energy
energy <- parse_nexis("./data/nexis/welt_online_energy.csv",
                      column_name = "energy")

# health
health <- parse_nexis("./data/nexis/welt_online_health.csv",
                      "health")

# immigration
immigration <- parse_nexis("./data/nexis/welt_online_immigration.csv",
                           "immigration")

# trade
trade <- parse_nexis("./data/nexis/welt_online_trade.csv",
                     "trade")

# join data frames
welt_online <- welt_online %>% 
  left_join(energy, by = c("date" = "date_parsed")) %>%
  left_join(health, by = c("date" = "date_parsed")) %>%
  left_join(immigration, by = c("date" = "date_parsed")) %>%
  left_join(trade, by = c("date" = "date_parsed"))

# fill NAs with 0
welt_online[is.na(welt_online)] <- 0

# save data frame
saveRDS(welt_online, "./data/welt_online.rds")

## WELT OFFLINE ----

# define empty data frame
welt_offline <- data.frame(date = timeframe,
                           stringsAsFactors = F)

# energy
energy <- parse_nexis("./data/nexis/welt_offline_energy.csv",
                      column_name = "energy")

# health
health <- parse_nexis("./data/nexis/welt_offline_health.csv",
                      "health")

# immigration
immigration <- parse_nexis("./data/nexis/welt_offline_immigration.csv",
                           "immigration")

# trade
trade <- parse_nexis("./data/nexis/welt_offline_trade.csv",
                     "trade")

# join data frames
welt_offline <- welt_offline %>% 
  left_join(energy, by = c("date" = "date_parsed")) %>%
  left_join(health, by = c("date" = "date_parsed")) %>%
  left_join(immigration, by = c("date" = "date_parsed")) %>%
  left_join(trade, by = c("date" = "date_parsed"))

# fill NAs with 0
welt_offline[is.na(welt_offline)] <- 0

# save data frame
saveRDS(welt_offline, "./data/welt_offline.rds")





