# load packages
library(stringr)

# load data
tweets <- readRDS("./data/tweets.rds")

# define dates
begin <- as.Date("2018-03-15")
end <- as.Date("2018-05-08")

# define date sequence for given time frame
timeframe <- seq(from = begin, 
                 to = end, 
                 by = 1)

## W/O AFD ----

# define empty data frame
tweets_wo_afd <- data.frame(date = timeframe,
                            stringsAsFactors = F)

# health
health <- tweets %>%
  filter(str_detect(topic, "Health")) %>% 
  filter(party != "AfD") %>% 
  group_by(date) %>% 
  summarise(health = n())

# energy
energy <- tweets %>%
  filter(str_detect(topic, "Energy")) %>% 
  filter(party != "AfD") %>% 
  group_by(date) %>% 
  summarise(energy = n())

# immigration
immigration <- tweets %>%
  filter(str_detect(topic, "Immigration")) %>% 
  filter(party != "AfD") %>% 
  group_by(date) %>% 
  summarise(immigration = n())

# trade
trade <- tweets %>%
  filter(str_detect(topic, "Foreign Trade")) %>% 
  filter(party != "AfD") %>% 
  group_by(date) %>% 
  summarise(trade = n())

# join data frames
tweets_wo_afd <- tweets_wo_afd %>% 
  left_join(health, by = c("date" = "date")) %>% 
  left_join(energy, by = c("date" = "date")) %>% 
  left_join(immigration, by = c("date" = "date")) %>% 
  left_join(trade, by = c("date" = "date"))

# replace NAs with 0
tweets_wo_afd[is.na(tweets_wo_afd)] <- 0

# save data frame
saveRDS(tweets_wo_afd, "./data/tweets_wo_afd.rds")

## AFD ----

# define empty data frame
tweets_afd <- data.frame(date = timeframe,
                         stringsAsFactors = F)

# health
health <- tweets %>%
  filter(str_detect(topic, "Health")) %>% 
  filter(party == "AfD") %>% 
  group_by(date) %>% 
  summarise(health = n())

# energy
energy <- tweets %>%
  filter(str_detect(topic, "Energy")) %>% 
  filter(party == "AfD") %>% 
  group_by(date) %>% 
  summarise(energy = n())

# immigration
immigration <- tweets %>%
  filter(str_detect(topic, "Immigration")) %>% 
  filter(party == "AfD") %>% 
  group_by(date) %>% 
  summarise(immigration = n())

# trade
trade <- tweets %>%
  filter(str_detect(topic, "Foreign Trade")) %>% 
  filter(party == "AfD") %>% 
  group_by(date) %>% 
  summarise(trade = n())

# join data frames
tweets_afd <- tweets_afd %>% 
  left_join(health, by = c("date" = "date")) %>% 
  left_join(energy, by = c("date" = "date")) %>% 
  left_join(immigration, by = c("date" = "date")) %>% 
  left_join(trade, by = c("date" = "date"))

# replace NAs with 0
tweets_afd[is.na(tweets_afd)] <- 0

# save data frame
saveRDS(tweets_afd, "./data/tweets_afd.rds")




