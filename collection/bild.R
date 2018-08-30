# load packages
library(readr)
library(dplyr)
library(stringr)

# load functions
source("./collection/helper/parse_nexis.R")

# define dates
begin <- as.Date("2018-03-15")
end <- as.Date("2018-05-08")

# define date sequence for given time frame
timeframe <- seq(from = begin, 
                 to = end, 
                 by = 1)

# define empty dfs
bild_online <- data.frame(date = timeframe,
                          stringsAsFactors = F)

bild_offline <- data.frame(date = timeframe,
                           stringsAsFactors = F)

# immigration ----

immigration_offline <- parse_nexis("./data/nexis/bild_offline_immigration.csv", 
                                   column_name = "immigration")
bild_offline <- bild_offline %>% 
  left_join(immigration_offline,
            by = c("date" = "date_parsed")) %>% 
  rename(immigration = n)

immigration_online <- parse_nexis("./data/nexis/bild_online_immigration.csv",
                                  column_name = "immigration")

bild_online <- bild_online %>% 
  left_join(immigration_online,
            by = c("date" = "date_parsed")) %>% 
  rename(immigration = n)


# fill NAs
bild_online[is.na(bild_online)] <- 0
bild_offline[is.na(bild_offline)] <- 0

# save dataframes
saveRDS(bild_online, "./data/bild_online.rds")
saveRDS(bild_offline, "./data/bild_offline.rds")
